class User < ActiveRecord::Base
  has_many :friends, :through => :friendships
  has_many :friendships, :dependent => :destroy
           
   def getMutualFriendsWith user
     intersection = friends & user.friends
   end
   
   def getNumberOfMutualFriendsWith user
     getMutualFriendsWith(user).length()
   end
   
   def getPeopleHeMightKnow
     pymk = []
     for friend in friends 
       pymk.push(friend.friends)
     end
     pymk= (pymk.flatten!.uniq! - friends) - [self]
     pymk.reject! { |x| x.getNumberOfMutualFriendsWith(self) == 0 }
     pymk.sort! { |a,b| b.getNumberOfMutualFriendsWith(self) <=> a.getNumberOfMutualFriendsWith(self) }
     return pymk
   end

end
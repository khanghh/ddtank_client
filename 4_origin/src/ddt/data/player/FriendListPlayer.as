package ddt.data.player
{
   import com.pickgliss.ui.controls.cell.INotSameHeightListCellData;
   
   public class FriendListPlayer extends PlayerInfo implements INotSameHeightListCellData
   {
       
      
      public var Mark:String = "";
      
      public var Relation:int;
      
      public var type:int = 1;
      
      public var titleText:String = "";
      
      public var titleNumText:String = "";
      
      public var titleIsSelected:Boolean;
      
      public var titleType:int;
      
      public var BBSFriends:Boolean;
      
      public var UserName:String;
      
      public var Birthday:String;
      
      public var BirthdayDate:Date;
      
      public var callBtnEnable:Boolean = true;
      
      public function FriendListPlayer()
      {
         super();
      }
      
      public function getCellHeight() : Number
      {
         if(type == 0)
         {
            return 33;
         }
         if(type == 1)
         {
            return 33;
         }
         return 53;
      }
      
      public function get StateID() : int
      {
         return playerState.StateID;
      }
   }
}

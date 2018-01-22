package ddt.data.player
{
   import consortion.ConsortionModelManager;
   import ddt.manager.PlayerManager;
   import ddt.view.character.Direction;
   import road7th.utils.DateUtils;
   
   public class ConsortiaPlayerInfo extends BasePlayer
   {
       
      
      public var PosX:int = 300;
      
      public var PosY:int = 300;
      
      public var Direct:Direction;
      
      public var privateID:int;
      
      public var DutyID:int;
      
      public var IsChat:Boolean;
      
      public var IsDiplomatism:Boolean;
      
      public var IsDownGrade:Boolean;
      
      public var IsEditorDescription:Boolean;
      
      public var IsEditorPlacard:Boolean;
      
      public var IsEditorUser:Boolean;
      
      public var IsExpel:Boolean;
      
      public var IsInvite:Boolean;
      
      public var IsManageDuty:Boolean;
      
      public var IsRatify:Boolean;
      
      public var RatifierID:int;
      
      public var RatifierName:String;
      
      public var Remark:String;
      
      private var _IsVote:Boolean;
      
      public var LastWeekRichesOffer:int;
      
      public var IsBandChat:Boolean;
      
      public var LastDate:String;
      
      public var isSelected:Boolean;
      
      public var type:int = 1;
      
      public var minute:int;
      
      public var day:int;
      
      public function ConsortiaPlayerInfo()
      {
         Direct = Direction.getDirectionFromAngle(2);
         super();
      }
      
      public function get IsVote() : Boolean
      {
         return _IsVote;
      }
      
      public function set IsVote(param1:Boolean) : void
      {
         _IsVote = param1;
      }
      
      public function get OffLineHour() : int
      {
         if(NickName == PlayerManager.Instance.Self.NickName || playerState.StateID != 0)
         {
            return -2;
         }
         var _loc4_:int = 0;
         var _loc3_:Date = DateUtils.dealWithStringDate(LastDate);
         var _loc2_:Date = DateUtils.dealWithStringDate(ConsortionModelManager.Instance.model.systemDate);
         var _loc1_:Number = (_loc2_.valueOf() - _loc3_.valueOf()) / 3600000;
         _loc4_ = _loc1_ < 1?-1:Number(Math.floor(_loc1_));
         if(_loc1_ < 1)
         {
            minute = _loc1_ * 60;
            if(minute <= 0)
            {
               minute = 1;
            }
         }
         if(_loc1_ > 24 && _loc1_ < 720)
         {
            day = Math.floor(_loc1_ / 24);
         }
         return _loc4_;
      }
      
      override public function set Grade(param1:int) : void
      {
         if(_grade == param1 || param1 <= 0)
         {
            return;
         }
         if(_grade != 0 && _grade < param1)
         {
            IsUpGrade = true;
         }
         _grade = param1;
         onPropertiesChanged("Grade");
      }
   }
}

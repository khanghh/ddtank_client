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
      
      public function set IsVote(value:Boolean) : void
      {
         _IsVote = value;
      }
      
      public function get OffLineHour() : int
      {
         if(NickName == PlayerManager.Instance.Self.NickName || playerState.StateID != 0)
         {
            return -2;
         }
         var totalHours:int = 0;
         var oldDate:Date = DateUtils.dealWithStringDate(LastDate);
         var nowDate:Date = DateUtils.dealWithStringDate(ConsortionModelManager.Instance.model.systemDate);
         var hours:Number = (nowDate.valueOf() - oldDate.valueOf()) / 3600000;
         totalHours = hours < 1?-1:Number(Math.floor(hours));
         if(hours < 1)
         {
            minute = hours * 60;
            if(minute <= 0)
            {
               minute = 1;
            }
         }
         if(hours > 24 && hours < 720)
         {
            day = Math.floor(hours / 24);
         }
         return totalHours;
      }
      
      override public function set Grade(value:int) : void
      {
         if(_grade == value || value <= 0)
         {
            return;
         }
         if(_grade != 0 && _grade < value)
         {
            IsUpGrade = true;
         }
         _grade = value;
         onPropertiesChanged("Grade");
      }
   }
}

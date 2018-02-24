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
      
      public function ConsortiaPlayerInfo(){super();}
      
      public function get IsVote() : Boolean{return false;}
      
      public function set IsVote(param1:Boolean) : void{}
      
      public function get OffLineHour() : int{return 0;}
      
      override public function set Grade(param1:int) : void{}
   }
}

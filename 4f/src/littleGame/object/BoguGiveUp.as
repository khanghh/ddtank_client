package littleGame.object
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ChatManager;
   import ddt.manager.SoundManager;
   import flash.display.Graphics;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import littleGame.LittleGameManager;
   import littleGame.interfaces.ILittleObject;
   import littleGame.model.LittleLiving;
   import littleGame.model.Scenario;
   import littleGame.view.InhaleNoteShape;
   import road7th.comm.PackageIn;
   
   public class BoguGiveUp extends Sprite implements ILittleObject
   {
      
      private static var MaxNoteCount:int = 3;
      
      public static var NoteCount:int = 0;
       
      
      private var _giveup:MovieClip;
      
      private var _scene:Scenario;
      
      private var _id:int;
      
      private var _target:LittleLiving;
      
      private var _maxInhaleCount:int = 5;
      
      private var _inhaleCount:int = 0;
      
      private var _noteShape:InhaleNoteShape;
      
      public function BoguGiveUp(){super();}
      
      public function get type() : String{return null;}
      
      public function initialize(param1:Scenario, param2:PackageIn) : void{}
      
      private function drawNote(param1:int, param2:int) : void{}
      
      public function get id() : int{return 0;}
      
      public function execute() : void{}
      
      public function invoke(param1:PackageIn) : void{}
      
      private function addEvent() : void{}
      
      private function __giveupOut(param1:MouseEvent) : void{}
      
      private function __giveupOver(param1:MouseEvent) : void{}
      
      private function __giveup(param1:MouseEvent) : void{}
      
      private function __giveupFrame(param1:Event) : void{}
      
      private function complete() : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}

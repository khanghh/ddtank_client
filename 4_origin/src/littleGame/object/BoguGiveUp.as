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
      
      public function BoguGiveUp()
      {
         super();
      }
      
      public function get type() : String
      {
         return "bogugiveup";
      }
      
      public function initialize(param1:Scenario, param2:PackageIn) : void
      {
         _scene = param1;
         _id = param2.readInt();
         _target = _scene.findLiving(param2.readInt());
         _maxInhaleCount = param2.readInt();
         execute();
      }
      
      private function drawNote(param1:int, param2:int) : void
      {
         if(_noteShape)
         {
            _noteShape.setNote(param1,param2);
         }
         else
         {
            _noteShape = new InhaleNoteShape(param1,param2);
            addChild(_noteShape);
            _noteShape.x = StageReferance.stageWidth - _noteShape.width >> 1;
            _noteShape.y = 20;
         }
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function execute() : void
      {
         var _loc2_:int = 0;
         _scene.selfInhaled = true;
         drawNote(_inhaleCount,_maxInhaleCount);
         StageReferance.stage.focus = null;
         var _loc1_:Graphics = graphics;
         _loc1_.beginFill(0,0);
         _loc1_.drawRect(0,0,StageReferance.stageWidth,StageReferance.stageHeight);
         _loc1_.endFill();
         if(LittleGameManager.Instance.mainStage.contains(ChatManager.Instance.view))
         {
            _loc2_ = LittleGameManager.Instance.mainStage.getChildIndex(ChatManager.Instance.view);
            LittleGameManager.Instance.mainStage.addChildAt(this,_loc2_);
         }
         else
         {
            LittleGameManager.Instance.mainStage.addChild(this);
         }
         _giveup = ClassUtils.CreatInstance("asset.littlegame.bogu.giveup");
         _giveup.x = 814;
         _giveup.y = 566;
         _giveup.gotoAndPlay("in");
         _giveup.buttonMode = true;
         _giveup.mouseChildren = false;
         addChild(_giveup);
         addEvent();
      }
      
      public function invoke(param1:PackageIn) : void
      {
         var _loc2_:int = param1.readInt();
         if(_loc2_ == 1 && NoteCount < MaxNoteCount)
         {
            _maxInhaleCount = param1.readInt();
            _inhaleCount = param1.readInt();
            drawNote(_inhaleCount,_maxInhaleCount);
         }
      }
      
      private function addEvent() : void
      {
         _giveup.addEventListener("click",__giveup);
         _giveup.addEventListener("mouseOver",__giveupOver);
         _giveup.addEventListener("mouseOut",__giveupOut);
      }
      
      private function __giveupOut(param1:MouseEvent) : void
      {
         if(_giveup)
         {
            _giveup.gotoAndStop("up");
         }
      }
      
      private function __giveupOver(param1:MouseEvent) : void
      {
         if(_giveup)
         {
            _giveup.gotoAndStop("over");
         }
      }
      
      private function __giveup(param1:MouseEvent) : void
      {
         param1.stopPropagation();
         _giveup.removeEventListener("click",__giveup);
         _giveup.removeEventListener("mouseOver",__giveupOver);
         _giveup.removeEventListener("mouseOut",__giveupOut);
         _giveup.removeEventListener("enterFrame",__giveupFrame);
         _giveup.mouseEnabled = false;
         _giveup.addEventListener("enterFrame",__giveupFrame);
         _giveup.gotoAndPlay("out");
         SoundManager.instance.play("160");
         _scene.selfPlayer.doAction("stand");
      }
      
      private function __giveupFrame(param1:Event) : void
      {
         var _loc2_:MovieClip = param1.currentTarget as MovieClip;
         if(_loc2_.currentFrame >= _loc2_.totalFrames)
         {
            _loc2_.removeEventListener("enterFrame",__giveupFrame);
            _loc2_.stop();
            complete();
         }
      }
      
      private function complete() : void
      {
         LittleGameManager.Instance.cancelInhaled(_target.id);
         _scene.removeObject(this);
      }
      
      private function removeEvent() : void
      {
         _giveup.removeEventListener("click",__giveup);
         _giveup.removeEventListener("mouseOver",__giveupOver);
         _giveup.removeEventListener("mouseOut",__giveupOut);
         _giveup.removeEventListener("enterFrame",__giveupFrame);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_giveup);
         _giveup = null;
         ObjectUtils.disposeObject(_noteShape);
         _noteShape = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

package newChickenBox
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ClassUtils;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import ddt.utils.PositionUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import newChickenBox.data.NewChickenBoxGoodsTempInfo;
   import newChickenBox.events.NewChickenBoxEvents;
   import newChickenBox.model.NewChickenBoxModel;
   import newChickenBox.view.NewChickenBoxCell;
   import newChickenBox.view.NewChickenBoxFrame;
   import newChickenBox.view.NewChickenBoxItem;
   import road7th.comm.PackageIn;
   
   public class NewChickenBoxControl extends EventDispatcher
   {
      
      private static var _instance:NewChickenBoxControl = null;
       
      
      private var newChickenBoxFrame:NewChickenBoxFrame;
      
      public var firstEnter:Boolean = true;
      
      private var _model:NewChickenBoxModel;
      
      private var timer:Timer;
      
      public function NewChickenBoxControl(){super();}
      
      public static function get instance() : NewChickenBoxControl{return null;}
      
      public function setup() : void{}
      
      private function init() : void{}
      
      private function getItem() : void{}
      
      private function addSocketEvent() : void{}
      
      private function __overshow(param1:CrazyTankSocketEvent) : void{}
      
      private function sendAgain(param1:TimerEvent) : void{}
      
      private function sendOverShow(param1:TimerEvent) : void{}
      
      private function __canclick(param1:PkgEvent) : void{}
      
      private function __showBoxFrameHandler(param1:Event) : void{}
      
      private function __openCard(param1:PkgEvent) : void{}
      
      private function __openEye(param1:PkgEvent) : void{}
      
      private function __closeActivityHandler(param1:Event) : void{}
      
      private function removeSocketEvent() : void{}
      
      public function get model() : NewChickenBoxModel{return null;}
   }
}

package petsBag.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.analyze.PetconfigAnalyzer;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import pet.data.PetInfo;
   import petsBag.PetsBagManager;
   import petsBag.view.item.SkillItem;
   import road7th.data.DictionaryEvent;
   
   public class PetGameSkillPnl extends Sprite implements Disposeable
   {
      
      public static var LvVSLockArray:Array = [20,40,60];
       
      
      private var _bg:DisplayObject;
      
      private var _items:Vector.<SkillItem>;
      
      private var _pet:PetInfo;
      
      public function PetGameSkillPnl(param1:PetInfo = null){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function __onChange(param1:Event) : void{}
      
      private function removeEvent() : void{}
      
      private function __skillItemClick(param1:MouseEvent) : void{}
      
      protected function __onAlertResponse(param1:FrameEvent) : void{}
      
      public function set pet(param1:PetInfo) : void{}
      
      private function __onUpdate(param1:DictionaryEvent) : void{}
      
      private function lockByIndex(param1:int) : void{}
      
      public function get UnLockItemIndex() : int{return 0;}
      
      public function dispose() : void{}
   }
}

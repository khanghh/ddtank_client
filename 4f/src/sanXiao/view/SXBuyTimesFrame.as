package sanXiao.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.command.NumberSelecter;
   import ddt.manager.LanguageMgr;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SoundManager;
   import ddt.view.DoubleSelectedItem;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class SXBuyTimesFrame extends BaseAlerFrame
   {
       
      
      private var _selecedItem:DoubleSelectedItem;
      
      public var buyFunction:Function;
      
      public var clickFunction:Function;
      
      private var _timesSelector:NumberSelecter;
      
      private var _txt:FilterFrameText;
      
      private var _target:Sprite;
      
      public var autoClose:Boolean = true;
      
      private var _timesLabel:FilterFrameText;
      
      public function SXBuyTimesFrame(){super();}
      
      public function set target(param1:Sprite) : void{}
      
      private function initView() : void{}
      
      private function initEvents() : void{}
      
      protected function onMoneyChange(param1:Event) : void{}
      
      private function removeEvnets() : void{}
      
      private function responseHander(param1:FrameEvent) : void{}
      
      public function get isBind() : Boolean{return false;}
      
      public function setTxt(param1:String) : void{}
      
      override public function dispose() : void{}
   }
}

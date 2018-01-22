package gameCommon.view
{
   import com.pickgliss.ui.ComponentFactory;
   import ddt.data.BagInfo;
   import ddt.data.PropInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.player.SelfInfo;
   import ddt.events.BagEvent;
   import ddt.events.ItemEvent;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.view.PropItemView;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import gameCommon.model.LocalPlayer;
   import gameCommon.view.propContainer.BaseGamePropBarView;
   import gameCommon.view.propContainer.PropShortCutView;
   import org.aswing.KeyStroke;
   import org.aswing.KeyboardManager;
   
   public class SelfPropContainBar extends BaseGamePropBarView
   {
      
      public static var USE_THREE_SKILL:String = "useThreeSkill";
      
      public static var USE_PLANE:String = "usePlane";
       
      
      private var _back:Bitmap;
      
      private var _info:SelfInfo;
      
      private var _shortCut:PropShortCutView;
      
      private var _myitems:Array;
      
      public function SelfPropContainBar(param1:LocalPlayer){super(null,null,null,null,null,null,null);}
      
      private function initData() : void{}
      
      private function __keyDown(param1:KeyboardEvent) : void{}
      
      override public function dispose() : void{}
      
      public function setLocalPlayer(param1:SelfInfo) : void{}
      
      private function __removeProp(param1:BagEvent) : void{}
      
      private function __updateProp(param1:BagEvent) : void{}
      
      override public function setClickEnabled(param1:Boolean, param2:Boolean) : void{}
      
      override protected function __click(param1:ItemEvent) : void{}
      
      override protected function __over(param1:ItemEvent) : void{}
      
      override protected function __out(param1:ItemEvent) : void{}
      
      public function addProp(param1:PropInfo) : void{}
      
      public function removeProp(param1:PropInfo) : void{}
   }
}

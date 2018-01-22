package catchInsect
{
   import catchInsect.event.InsectEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.EquipType;
   import ddt.data.PropInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.data.player.SelfInfo;
   import ddt.events.BagEvent;
   import ddt.events.FightPropEevnt;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.KeyboardEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import gameCommon.model.LocalPlayer;
   import gameCommon.view.prop.CustomPropCell;
   import gameCommon.view.prop.FightPropBar;
   import gameCommon.view.prop.PropCell;
   import org.aswing.KeyStroke;
   import org.aswing.KeyboardManager;
   
   public class InsectProBar extends FightPropBar
   {
       
      
      private var _selfInfo:SelfInfo;
      
      private var _type:int;
      
      private var _backStyle:String;
      
      private var _localVisible:Boolean = true;
      
      private var _lock0:Boolean;
      
      private var _lock1:Boolean;
      
      private var _ballTips:Bitmap;
      
      private var _netTips:Bitmap;
      
      public function InsectProBar(param1:LocalPlayer, param2:int){super(null);}
      
      override protected function addEvent() : void{}
      
      private function __updateProp(param1:BagEvent) : void{}
      
      override protected function removeEvent() : void{}
      
      override protected function drawCells() : void{}
      
      override protected function __keyDown(param1:KeyboardEvent) : void{}
      
      private function __useProp(param1:FightPropEevnt) : void{}
      
      override public function enter() : void{}
      
      override public function leaving() : void{}
      
      public function set backStyle(param1:String) : void{}
      
      public function setVisible(param1:Boolean) : void{}
      
      public function setEnable(param1:Boolean) : void{}
      
      public function showBallTips() : void{}
   }
}

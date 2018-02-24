package ddt.view.buff.buffButton
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.core.ITipedDisplay;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.BuffInfo;
   import ddt.manager.PlayerManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import ddt.view.tips.BuffTipInfo;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class BuffButton extends Sprite implements Disposeable, ITipedDisplay
   {
      
      protected static var Setting:Boolean = false;
       
      
      protected var _info:BuffInfo;
      
      private var _canClick:Boolean;
      
      protected var _bg:Bitmap;
      
      protected var _tipStyle:String;
      
      protected var _tipData:BuffTipInfo;
      
      protected var _tipDirctions:String;
      
      protected var _tipGapV:int;
      
      protected var _tipGapH:int;
      
      public function BuffButton(param1:String)
      {
         super();
         _bg = ComponentFactory.Instance.creatBitmap(param1);
         var _loc2_:int = 33;
         _bg.height = _loc2_;
         _bg.width = _loc2_;
         addChild(_bg);
         _canClick = true;
         buttonMode = _canClick;
         _tipStyle = "core.buffTip";
         _tipGapV = 2;
         _tipGapH = 2;
         _tipDirctions = "7,6,5,1,6,4";
         ShowTipManager.Instance.addTip(this);
         initEvents();
      }
      
      public static function createBuffButton(param1:int, param2:String = "") : BuffButton
      {
         var _loc4_:* = null;
         var _loc3_:* = null;
         switch(int(param1))
         {
            case 0:
               _loc4_ = new DoubExpBuffButton();
               return _loc4_;
            case 1:
               _loc3_ = new DoubGesteBuffButton();
               return _loc3_;
            case 2:
               return new DoublePrestigeBuffButton();
            case 3:
               return new DoubleContributeButton();
            case 4:
               return new RandomSuitButton();
         }
      }
      
      private function initEvents() : void
      {
         addEventListener("click",__onclick);
         addEventListener("mouseOver",__onMouseOver);
         addEventListener("mouseOut",__onMouseOut);
      }
      
      protected function __onclick(param1:MouseEvent) : void
      {
         if(!CanClick)
         {
            return;
         }
         SoundManager.instance.play("008");
      }
      
      protected function __onMouseOver(param1:MouseEvent) : void
      {
         if(_info && _info.IsExist)
         {
            filters = ComponentFactory.Instance.creatFilters("lightFilter");
         }
      }
      
      protected function __onMouseOut(param1:MouseEvent) : void
      {
         if(_info && _info.IsExist)
         {
            filters = null;
         }
      }
      
      protected function checkBagLocked() : Boolean
      {
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return false;
         }
         return true;
      }
      
      protected function buyBuff(param1:Boolean = true) : void
      {
         SocketManager.Instance.out.sendUseCard(-1,-1,[ShopManager.Instance.getMoneyShopItemByTemplateID(_info.buffItemInfo.TemplateID).GoodsID],1,false,param1);
      }
      
      protected function createTipRender() : Sprite
      {
         return new Sprite();
      }
      
      public function setSize(param1:Number, param2:Number) : void
      {
         param1 = param1;
         param2 = param2;
      }
      
      private function updateView() : void
      {
         if(_info != null && _info.IsExist)
         {
            filters = null;
         }
         else
         {
            filters = ComponentFactory.Instance.creatFilters("grayFilter");
         }
      }
      
      public function set CanClick(param1:Boolean) : void
      {
         _canClick = param1;
         buttonMode = _canClick;
      }
      
      public function get CanClick() : Boolean
      {
         return _canClick;
      }
      
      public function set info(param1:BuffInfo) : void
      {
         _info = param1;
         if(_info.Type != 14 && _info.Type != 17)
         {
            updateView();
         }
      }
      
      public function get info() : BuffInfo
      {
         return _info;
      }
      
      protected function __onBuyResponse(param1:FrameEvent) : void
      {
         var _loc2_:int = 0;
         Setting = false;
         SoundManager.instance.play("008");
         var _loc3_:Boolean = (param1.target as BaseAlerFrame).isBand;
         (param1.target as BaseAlerFrame).removeEventListener("response",__onBuyResponse);
         (param1.target as BaseAlerFrame).dispose();
         if(param1.responseCode == 2 || param1.responseCode == 3)
         {
            _loc2_ = ShopManager.Instance.getMoneyShopItemByTemplateID(_info.buffItemInfo.TemplateID).getItemPrice(1).bothMoneyValue;
            CheckMoneyUtils.instance.checkMoney(_loc3_,_loc2_,onCheckComplete);
         }
      }
      
      protected function onCheckComplete() : void
      {
         buyBuff(CheckMoneyUtils.instance.isBind);
      }
      
      public function dispose() : void
      {
         removeEventListener("click",__onclick);
         removeEventListener("mouseOver",__onMouseOver);
         removeEventListener("mouseOut",__onMouseOut);
         ObjectUtils.disposeAllChildren(this);
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         _info = null;
         ShowTipManager.Instance.removeTip(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function get tipStyle() : String
      {
         return _tipStyle;
      }
      
      public function set tipStyle(param1:String) : void
      {
         _tipStyle = param1;
      }
      
      public function get tipData() : Object
      {
         _tipData = new BuffTipInfo();
         if(_info)
         {
            _tipData.isActive = _info.IsExist;
            _tipData.describe = _info.description;
            _tipData.name = _info.buffName;
            _tipData.isFree = false;
            _tipData.day = _info.getLeftTimeByUnit(86400000);
            _tipData.hour = _info.getLeftTimeByUnit(3600000);
            _tipData.min = _info.getLeftTimeByUnit(60000);
         }
         return _tipData;
      }
      
      public function set tipData(param1:Object) : void
      {
         _tipData = param1 as BuffTipInfo;
      }
      
      public function get tipDirctions() : String
      {
         return _tipDirctions;
      }
      
      public function set tipDirctions(param1:String) : void
      {
         _tipDirctions = param1;
      }
      
      public function get tipGapV() : int
      {
         return _tipGapV;
      }
      
      public function set tipGapV(param1:int) : void
      {
         _tipGapV = param1;
      }
      
      public function get tipGapH() : int
      {
         return _tipGapH;
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function set tipGapH(param1:int) : void
      {
         _tipGapH = param1;
      }
   }
}

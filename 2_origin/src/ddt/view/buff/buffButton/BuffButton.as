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
      
      public function BuffButton(bgString:String)
      {
         super();
         _bg = ComponentFactory.Instance.creatBitmap(bgString);
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
      
      public static function createBuffButton(buffID:int, str:String = "") : BuffButton
      {
         var doubleExp:* = null;
         var doubleGeste:* = null;
         switch(int(buffID))
         {
            case 0:
               doubleExp = new DoubExpBuffButton();
               return doubleExp;
            case 1:
               doubleGeste = new DoubGesteBuffButton();
               return doubleGeste;
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
      
      protected function __onclick(evt:MouseEvent) : void
      {
         if(!CanClick)
         {
            return;
         }
         SoundManager.instance.play("008");
      }
      
      protected function __onMouseOver(evt:MouseEvent) : void
      {
         if(_info && _info.IsExist)
         {
            filters = ComponentFactory.Instance.creatFilters("lightFilter");
         }
      }
      
      protected function __onMouseOut(evt:MouseEvent) : void
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
      
      protected function buyBuff(bool:Boolean = true) : void
      {
         SocketManager.Instance.out.sendUseCard(-1,-1,[ShopManager.Instance.getMoneyShopItemByTemplateID(_info.buffItemInfo.TemplateID).GoodsID],1,false,bool);
      }
      
      protected function createTipRender() : Sprite
      {
         return new Sprite();
      }
      
      public function setSize(width:Number, height:Number) : void
      {
         width = width;
         height = height;
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
      
      public function set CanClick(value:Boolean) : void
      {
         _canClick = value;
         buttonMode = _canClick;
      }
      
      public function get CanClick() : Boolean
      {
         return _canClick;
      }
      
      public function set info(value:BuffInfo) : void
      {
         _info = value;
         if(_info.Type != 14 && _info.Type != 17)
         {
            updateView();
         }
      }
      
      public function get info() : BuffInfo
      {
         return _info;
      }
      
      protected function __onBuyResponse(evt:FrameEvent) : void
      {
         var needMoney:int = 0;
         Setting = false;
         SoundManager.instance.play("008");
         var isBand:Boolean = (evt.target as BaseAlerFrame).isBand;
         (evt.target as BaseAlerFrame).removeEventListener("response",__onBuyResponse);
         (evt.target as BaseAlerFrame).dispose();
         if(evt.responseCode == 2 || evt.responseCode == 3)
         {
            needMoney = ShopManager.Instance.getMoneyShopItemByTemplateID(_info.buffItemInfo.TemplateID).getItemPrice(1).bothMoneyValue;
            CheckMoneyUtils.instance.checkMoney(isBand,needMoney,onCheckComplete);
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
      
      public function set tipStyle(value:String) : void
      {
         _tipStyle = value;
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
      
      public function set tipData(value:Object) : void
      {
         _tipData = value as BuffTipInfo;
      }
      
      public function get tipDirctions() : String
      {
         return _tipDirctions;
      }
      
      public function set tipDirctions(value:String) : void
      {
         _tipDirctions = value;
      }
      
      public function get tipGapV() : int
      {
         return _tipGapV;
      }
      
      public function set tipGapV(value:int) : void
      {
         _tipGapV = value;
      }
      
      public function get tipGapH() : int
      {
         return _tipGapH;
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function set tipGapH(value:int) : void
      {
         _tipGapH = value;
      }
   }
}

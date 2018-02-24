package Indiana.item
{
   import Indiana.IndianaDataManager;
   import Indiana.analyzer.IndianaShopItemInfo;
   import Indiana.model.IndianaShowData;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.TextEvent;
   import road7th.utils.DateUtils;
   
   public class IndianaResoultSuccess extends Sprite implements Disposeable
   {
       
      
      private var _luckBg:Bitmap;
      
      private var _luckNum:GradientBitmapText;
      
      private var _nameitem:AttributeItem;
      
      private var _severitem:AttributeItem;
      
      private var _timesnumitem:AttributeItem;
      
      private var _timeitem:AttributeItem;
      
      private var _resoultitem:AttributeItem;
      
      private var _lookNum:FilterFrameText;
      
      private var _lookNumself:FilterFrameText;
      
      private var _lookNumselfII:FilterFrameText;
      
      private var _line:MutipleImage;
      
      private var _data:IndianaShowData;
      
      private var _info:IndianaShopItemInfo;
      
      public function IndianaResoultSuccess(){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function __linkHandler(param1:TextEvent) : void{}
      
      private function setShowData() : void{}
      
      public function setInfo(param1:IndianaShopItemInfo) : void{}
      
      public function dispose() : void{}
   }
}

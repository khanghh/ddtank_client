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
   
   public class IndianaResoultLose extends Sprite implements Disposeable
   {
       
      
      private var _prompte:Bitmap;
      
      private var _txt:GradientBitmapText;
      
      private var _dis:FilterFrameText;
      
      private var _disII:FilterFrameText;
      
      private var _lookNum:FilterFrameText;
      
      private var _line:MutipleImage;
      
      private var _info:IndianaShopItemInfo;
      
      private var _endDate:Date;
      
      private var _data:IndianaShowData;
      
      public function IndianaResoultLose(){super();}
      
      public function setInfo(param1:IndianaShopItemInfo) : void{}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function __linkHandler(param1:TextEvent) : void{}
      
      public function dispose() : void{}
   }
}

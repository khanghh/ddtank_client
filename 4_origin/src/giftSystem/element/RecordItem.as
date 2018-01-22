package giftSystem.element
{
   import bagAndInfo.cell.CellFactory;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.TiledImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.RecordItemInfo;
   import ddt.data.goods.ShopItemInfo;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import giftSystem.GiftManager;
   import shop.view.ShopItemCell;
   
   public class RecordItem extends Sprite implements Disposeable
   {
      
      private static var THISHEIGHT:int = 52;
      
      public static const RECEIVED:int = 1;
      
      public static const SENDED:int = 0;
       
      
      private var _playerInfo:PlayerInfo;
      
      private var _info:RecordItemInfo;
      
      private var _headTxt:FilterFrameText;
      
      private var _giftNameTxt:FilterFrameText;
      
      private var _giftCountTxt:FilterFrameText;
      
      private var _playerName:FilterFrameText;
      
      private var _itemCell:ShopItemCell;
      
      private var _clickSp:Sprite;
      
      private var _recordItemBg:MovieImage;
      
      private var _line1:TiledImage;
      
      private var _nameAction:Boolean;
      
      private var _index:int;
      
      private var _receiedIcon:Bitmap;
      
      private var _sendIcon:Bitmap;
      
      private var _showed:Boolean = false;
      
      public function RecordItem()
      {
         super();
      }
      
      public function setup(param1:PlayerInfo) : void
      {
         initView();
         _playerInfo = param1;
      }
      
      private function initView() : void
      {
         _recordItemBg = ComponentFactory.Instance.creatComponentByStylename("ddtGiftRecordItem.BG");
         _line1 = ComponentFactory.Instance.creatComponentByStylename("ddtGiftRecordItem.line1");
         _receiedIcon = ComponentFactory.Instance.creatBitmap("asset.ddtgift.Receive.bg");
         _sendIcon = ComponentFactory.Instance.creatBitmap("asset.ddtgift.Send.bg");
         _headTxt = ComponentFactory.Instance.creatComponentByStylename("RecordItem.headTxt");
         _giftNameTxt = ComponentFactory.Instance.creatComponentByStylename("RecordItem.giftNameTxt");
         _giftCountTxt = ComponentFactory.Instance.creatComponentByStylename("RecordItem.giftCountTxt");
         var _loc1_:Sprite = new Sprite();
         _loc1_.graphics.beginFill(16777215,0);
         _loc1_.graphics.drawRect(0,0,50,50);
         _loc1_.graphics.endFill();
         _itemCell = CellFactory.instance.createShopItemCell(_loc1_,null,true,true) as ShopItemCell;
         _itemCell.cellSize = 46;
         addChild(_recordItemBg);
         addChild(_line1);
         addChild(_receiedIcon);
         addChild(_sendIcon);
         addChild(_headTxt);
         addChild(_giftNameTxt);
         addChild(_giftCountTxt);
         addChild(_itemCell);
         _receiedIcon.visible = false;
         _sendIcon.visible = false;
      }
      
      public function setItemInfoType(param1:RecordItemInfo, param2:int) : void
      {
         if(_info == param1 || param1 == null)
         {
            return;
         }
         _info = param1;
         var _loc3_:ShopItemInfo = _info.info;
         if(_loc3_ == null)
         {
            return;
         }
         _itemCell.info = _loc3_.TemplateInfo;
         switch(int(param2))
         {
            case 0:
               upSendedItemView();
               break;
            case 1:
               upReceivedItemView();
         }
      }
      
      private function upReceivedItemView() : void
      {
         _receiedIcon.visible = true;
         _sendIcon.visible = false;
         _headTxt.text = LanguageMgr.GetTranslation("ddt.giftSystem.RecordItem.receivedHeadTxt");
         _giftNameTxt.text = LanguageMgr.GetTranslation("ddt.giftSystem.RecordItem.receivedGiftName",_info.info.TemplateInfo.Name);
         _giftCountTxt.text = LanguageMgr.GetTranslation("ddt.giftSystem.RecordItem.giftCount",_info.count);
         _playerName = ComponentFactory.Instance.creatComponentByStylename("RecordItem.receiverTxt");
         addChild(_playerName);
         _playerName.text = _info.name;
         if(GiftManager.Instance.canActive && _info.playerID != 0 && !GiftManager.Instance.inChurch)
         {
            _clickSp = new Sprite();
            _clickSp.graphics.beginFill(16711680,0);
            _clickSp.graphics.drawRect(0,0,_playerName.textWidth,_playerName.textHeight);
            _clickSp.graphics.endFill();
            addChild(_clickSp);
            _clickSp.buttonMode = true;
            _clickSp.y = _playerName.y;
            _clickSp.addEventListener("click",__clickHandler);
         }
         upPos();
      }
      
      private function upSendedItemView() : void
      {
         _recordItemBg.visible = false;
         _receiedIcon.visible = false;
         _sendIcon.visible = true;
         _headTxt.text = LanguageMgr.GetTranslation("ddt.giftSystem.RecordItem.sendedHeadTxt");
         _giftNameTxt.text = _info.info.TemplateInfo.Name;
         _giftCountTxt.text = LanguageMgr.GetTranslation("ddt.giftSystem.RecordItem.giftCount",_info.count);
         _playerName = ComponentFactory.Instance.creatComponentByStylename("RecordItem.senderTxt");
         addChild(_playerName);
         _playerName.text = _info.name;
         if(_playerName.text.length > 10)
         {
            _playerName.text = _playerName.text.substr(0,7) + "...";
         }
         upPos();
      }
      
      private function upPos() : void
      {
         _playerName.x = _headTxt.x + _headTxt.textWidth + 4;
         if(_clickSp)
         {
            _clickSp.x = _playerName.x;
         }
         _giftNameTxt.x = _playerName.x + _playerName.textWidth + 4;
         _itemCell.x = _giftNameTxt.x + _giftNameTxt.textWidth;
         _itemCell.y = -5;
         _giftCountTxt.x = _itemCell.x + _itemCell.width + 4;
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         RebackMenu.Instance.show(_info,StageReferance.stage.mouseX,StageReferance.stage.mouseY);
      }
      
      override public function get height() : Number
      {
         return THISHEIGHT;
      }
      
      public function dispose() : void
      {
         if(GiftManager.Instance.canActive && _playerName)
         {
            _playerName.removeEventListener("click",__clickHandler);
         }
         _info = null;
         if(_recordItemBg)
         {
            ObjectUtils.disposeObject(_recordItemBg);
         }
         _recordItemBg = null;
         if(_line1)
         {
            ObjectUtils.disposeObject(_line1);
         }
         _line1 = null;
         if(_receiedIcon)
         {
            ObjectUtils.disposeObject(_receiedIcon);
         }
         _receiedIcon = null;
         if(_sendIcon)
         {
            ObjectUtils.disposeObject(_sendIcon);
         }
         _sendIcon = null;
         if(_headTxt)
         {
            ObjectUtils.disposeObject(_headTxt);
         }
         _headTxt = null;
         if(_giftNameTxt)
         {
            ObjectUtils.disposeObject(_giftNameTxt);
         }
         _giftNameTxt = null;
         if(_giftCountTxt)
         {
            ObjectUtils.disposeObject(_giftCountTxt);
         }
         _giftCountTxt = null;
         if(_playerName)
         {
            ObjectUtils.disposeObject(_playerName);
         }
         _playerName = null;
         if(_itemCell)
         {
            ObjectUtils.disposeObject(_itemCell);
         }
         _itemCell = null;
         if(_clickSp)
         {
            ObjectUtils.disposeObject(_clickSp);
         }
         _clickSp = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}

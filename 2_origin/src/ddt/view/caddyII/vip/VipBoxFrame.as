package ddt.view.caddyII.vip
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.BagEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.view.caddyII.CaddyBagView;
   import ddt.view.caddyII.CaddyEvent;
   import ddt.view.caddyII.CaddyModel;
   import ddt.view.caddyII.MoveSprite;
   import flash.events.Event;
   
   public class VipBoxFrame extends Frame
   {
      
      public static const VerticalOffset:int = -50;
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _view:VipViewII;
      
      private var _bag:CaddyBagView;
      
      private var _moveSprite:MoveSprite;
      
      private var _closeAble:Boolean = true;
      
      private var _itemInfo:ItemTemplateInfo;
      
      private var _type:int;
      
      private var _caddyAwardCount:int = 0;
      
      private var _closed:Boolean = false;
      
      private var _selectInfo:InventoryItemInfo;
      
      public function VipBoxFrame(type:int, itemInfo:ItemTemplateInfo = null)
      {
         super();
         _itemInfo = itemInfo;
         _type = type;
         initView(type);
         initEvents();
      }
      
      public function setCaddyType(id:int) : void
      {
         CaddyModel.instance.caddyType = id;
      }
      
      public function setBeadType(id:int) : void
      {
         CaddyModel.instance.beadType = id;
      }
      
      public function setOfferType(id:int) : void
      {
         CaddyModel.instance.offerType = id;
      }
      
      public function setCardType(id:int, place:int) : void
      {
         _view.setCard(id,place);
      }
      
      private function initView(type:int) : void
      {
         CaddyModel.instance.setup(type);
         _bg = ComponentFactory.Instance.creatComponentByStylename("asset.vipFrame.bg");
         addToContent(_bg);
         _view = ComponentFactory.Instance.creatCustomObject("caddy.VipViewII");
         _view.item = _itemInfo;
         addToContent(_view);
         _bag = ComponentFactory.Instance.creatCustomObject("caddy.CaddyBagView");
         addToContent(_bag);
         _moveSprite = ComponentFactory.Instance.creatCustomObject("caddy.MoveSprite",[_itemInfo]);
         addToContent(_moveSprite);
      }
      
      private function initEvents() : void
      {
         addEventListener("response",_response);
         _view.addEventListener("caddy_start_turn",_startTurn);
         _view.addEventListener("start_move_after_turn",_turnComplete);
         _bag.addEventListener("send_nullCell_poing",_getCellPoint);
         _bag.addEventListener("caddy_get_goodsinfo",_getGoodsInfo);
         _moveSprite.addEventListener("questCellPoint",_questCellPoint);
         _moveSprite.addEventListener("move_complete",_moveComplete);
         SocketManager.Instance.addEventListener(PkgEvent.format(26),__lotteryOpen);
      }
      
      private function __lotteryOpen(event:PkgEvent) : void
      {
         if(_itemInfo && (_itemInfo.TemplateID == 112047 || _itemInfo.TemplateID == 112222))
         {
            _caddyAwardCount = event.pkg.readInt();
         }
      }
      
      private function removeEvents() : void
      {
         removeEventListener("response",_response);
         _view.removeEventListener("caddy_start_turn",_startTurn);
         _view.removeEventListener("start_move_after_turn",_turnComplete);
         _bag.removeEventListener("send_nullCell_poing",_getCellPoint);
         _bag.removeEventListener("caddy_get_goodsinfo",_getGoodsInfo);
         _moveSprite.removeEventListener("questCellPoint",_questCellPoint);
         _moveSprite.removeEventListener("move_complete",_moveComplete);
         SocketManager.Instance.removeEventListener(PkgEvent.format(26),__lotteryOpen);
      }
      
      private function _response(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         if(!_view.openBtnEnable)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.caddy.VipClose"));
            return;
         }
         if(evt.responseCode == 0 || evt.responseCode == 1)
         {
            if(_bag.checkCell())
            {
               _showCloseAlert();
            }
            else
            {
               ObjectUtils.disposeObject(this);
            }
         }
      }
      
      private function _responseII(e:FrameEvent) : void
      {
         var alert:* = null;
         SoundManager.instance.play("008");
         (e.currentTarget as BaseAlerFrame).removeEventListener("response",_responseII);
         switch(int(e.responseCode))
         {
            case 0:
            case 1:
               ObjectUtils.disposeObject(e.currentTarget);
               break;
            case 2:
            case 3:
               ObjectUtils.disposeObject(e.currentTarget);
               ObjectUtils.disposeObject(this);
               if(_type == 2)
               {
                  PlayerManager.Instance.Self.dispatchEvent(new BagEvent("showBead",null));
                  break;
               }
               break;
            case 4:
               alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.caddy.sellAllNode") + _bag.getSellAllPriceString(),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,true,2);
               alert.moveEnable = false;
               alert.addEventListener("response",_responseI);
               ObjectUtils.disposeObject(e.currentTarget);
         }
      }
      
      private function _responseI(e:FrameEvent) : void
      {
         (e.currentTarget as BaseAlerFrame).removeEventListener("response",_responseI);
         if(e.responseCode == 2 || e.responseCode == 3)
         {
            SocketManager.Instance.out.sendSellAll();
         }
         else
         {
            _showCloseAlert();
         }
         ObjectUtils.disposeObject(e.currentTarget);
      }
      
      private function _showCloseAlert() : void
      {
         var alert:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.caddy.closeNode"),LanguageMgr.GetTranslation("tank.view.caddy.putInBag"),LanguageMgr.GetTranslation("tank.view.caddy.sellAll"),false,false,false,2);
         alert.addEventListener("response",_responseII);
      }
      
      private function _questCellPoint(e:Event) : void
      {
         _bag.findCell();
      }
      
      private function _turnComplete(e:Event) : void
      {
         if(_selectInfo.TemplateID == 11550)
         {
            _startMove(null);
         }
         else
         {
            _moveComplete(null);
         }
      }
      
      private function _moveComplete(e:Event) : void
      {
         if(_closed)
         {
            return;
         }
         _bag.addCell();
         _view.again();
         if(_view.openBtnEnable)
         {
            _bag.sellBtn.enable = true;
         }
         closeAble = true;
      }
      
      private function _startTurn(e:CaddyEvent) : void
      {
         _moveSprite.setInfo(e.info);
         _bag.sellBtn.enable = false;
         closeAble = false;
      }
      
      public function turnComplete(e:Event) : void
      {
      }
      
      private function _startMove(e:Event) : void
      {
         _moveSprite.startMove();
      }
      
      private function _getCellPoint(e:CaddyEvent) : void
      {
         _moveSprite.setMovePoint(e.point);
      }
      
      private function _getGoodsInfo(e:CaddyEvent) : void
      {
         _selectInfo = e.info;
         if(!_closed)
         {
            _view.setSelectGoodsInfo(e.info);
         }
      }
      
      public function show() : void
      {
         _view.setType(13);
         titleText = LanguageMgr.GetTranslation("tank.view.vip.title");
         escEnable = true;
         LayerManager.Instance.addToLayer(this,3,true,1);
         y = y + -50;
      }
      
      public function set closeAble(value:Boolean) : void
      {
         _closeAble = value;
      }
      
      public function get closeAble() : Boolean
      {
         return _closeAble;
      }
      
      override public function dispose() : void
      {
         removeEvents();
         SocketManager.Instance.out.sendFinishRoulette();
         _closed = true;
         if(_view)
         {
            ObjectUtils.disposeObject(_view);
         }
         _view = null;
         if(_bag)
         {
            ObjectUtils.disposeObject(_bag);
         }
         _bag = null;
         if(_moveSprite)
         {
            ObjectUtils.disposeObject(_moveSprite);
         }
         _moveSprite = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

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
      
      public function VipBoxFrame(param1:int, param2:ItemTemplateInfo = null)
      {
         super();
         _itemInfo = param2;
         _type = param1;
         initView(param1);
         initEvents();
      }
      
      public function setCaddyType(param1:int) : void
      {
         CaddyModel.instance.caddyType = param1;
      }
      
      public function setBeadType(param1:int) : void
      {
         CaddyModel.instance.beadType = param1;
      }
      
      public function setOfferType(param1:int) : void
      {
         CaddyModel.instance.offerType = param1;
      }
      
      public function setCardType(param1:int, param2:int) : void
      {
         _view.setCard(param1,param2);
      }
      
      private function initView(param1:int) : void
      {
         CaddyModel.instance.setup(param1);
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
      
      private function __lotteryOpen(param1:PkgEvent) : void
      {
         if(_itemInfo && (_itemInfo.TemplateID == 112047 || _itemInfo.TemplateID == 112222))
         {
            _caddyAwardCount = param1.pkg.readInt();
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
      
      private function _response(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         if(!_view.openBtnEnable)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.caddy.VipClose"));
            return;
         }
         if(param1.responseCode == 0 || param1.responseCode == 1)
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
      
      private function _responseII(param1:FrameEvent) : void
      {
         var _loc2_:* = null;
         SoundManager.instance.play("008");
         (param1.currentTarget as BaseAlerFrame).removeEventListener("response",_responseII);
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               ObjectUtils.disposeObject(param1.currentTarget);
               break;
            case 2:
            case 3:
               ObjectUtils.disposeObject(param1.currentTarget);
               ObjectUtils.disposeObject(this);
               if(_type == 2)
               {
                  PlayerManager.Instance.Self.dispatchEvent(new BagEvent("showBead",null));
                  break;
               }
               break;
            case 4:
               _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.caddy.sellAllNode") + _bag.getSellAllPriceString(),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,true,2);
               _loc2_.moveEnable = false;
               _loc2_.addEventListener("response",_responseI);
               ObjectUtils.disposeObject(param1.currentTarget);
         }
      }
      
      private function _responseI(param1:FrameEvent) : void
      {
         (param1.currentTarget as BaseAlerFrame).removeEventListener("response",_responseI);
         if(param1.responseCode == 2 || param1.responseCode == 3)
         {
            SocketManager.Instance.out.sendSellAll();
         }
         else
         {
            _showCloseAlert();
         }
         ObjectUtils.disposeObject(param1.currentTarget);
      }
      
      private function _showCloseAlert() : void
      {
         var _loc1_:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.caddy.closeNode"),LanguageMgr.GetTranslation("tank.view.caddy.putInBag"),LanguageMgr.GetTranslation("tank.view.caddy.sellAll"),false,false,false,2);
         _loc1_.addEventListener("response",_responseII);
      }
      
      private function _questCellPoint(param1:Event) : void
      {
         _bag.findCell();
      }
      
      private function _turnComplete(param1:Event) : void
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
      
      private function _moveComplete(param1:Event) : void
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
      
      private function _startTurn(param1:CaddyEvent) : void
      {
         _moveSprite.setInfo(param1.info);
         _bag.sellBtn.enable = false;
         closeAble = false;
      }
      
      public function turnComplete(param1:Event) : void
      {
      }
      
      private function _startMove(param1:Event) : void
      {
         _moveSprite.startMove();
      }
      
      private function _getCellPoint(param1:CaddyEvent) : void
      {
         _moveSprite.setMovePoint(param1.point);
      }
      
      private function _getGoodsInfo(param1:CaddyEvent) : void
      {
         _selectInfo = param1.info;
         if(!_closed)
         {
            _view.setSelectGoodsInfo(param1.info);
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
      
      public function set closeAble(param1:Boolean) : void
      {
         _closeAble = param1;
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

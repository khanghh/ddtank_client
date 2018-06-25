package ddt.view.caddyII.reader
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.tip.BaseTip;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.PkgEvent;
   import ddt.manager.SocketManager;
   import ddt.view.caddyII.CaddyEvent;
   import ddt.view.caddyII.CaddyModel;
   import ddt.view.tips.CardBoxTipPanel;
   import ddt.view.tips.GoodTip;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import road7th.comm.PackageIn;
   
   public class BlessReadAwardsView extends Sprite implements Disposeable, CaddyUpdate
   {
       
      
      private var _bg1:ScaleBitmapImage;
      
      protected var _bg2:MovieImage;
      
      private var _node:Bitmap;
      
      protected var _list:VBox;
      
      protected var _panel:ScrollPanel;
      
      private var _goodTip:GoodTip;
      
      private var _cardTip:CardBoxTipPanel;
      
      protected var _goodTipPos:Point;
      
      private var _tipStageClickCount:int;
      
      private var _isMySelf:Boolean;
      
      private var tempArr:Vector.<AwardsInfo>;
      
      public function BlessReadAwardsView()
      {
         super();
         initView();
         initEvents();
         requestAwards();
      }
      
      protected function initView() : void
      {
         _bg2 = ComponentFactory.Instance.creatComponentByStylename("caddy.readAwardsBGIII");
         _list = ComponentFactory.Instance.creatComponentByStylename("caddy.readVBox");
         _panel = ComponentFactory.Instance.creatComponentByStylename("caddy.CaddyReaderScrollpanel");
         _panel.setView(_list);
         _panel.invalidateViewport();
         addChild(_bg2);
         addChild(_panel);
         _goodTipPos = new Point();
         _panel.invalidateViewport(true);
      }
      
      private function initEvents() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(245),_getAwards);
         CaddyModel.instance.addEventListener("bless_change",_awardsChange);
      }
      
      private function removeEvents() : void
      {
         SocketManager.Instance.removeEventListener(PkgEvent.format(245),_getAwards);
         CaddyModel.instance.removeEventListener("bless_change",_awardsChange);
      }
      
      private function requestAwards() : void
      {
         SocketManager.Instance.out.sendRequestAwards(CaddyModel.instance.type + 1);
      }
      
      private function _getAwards(evt:PkgEvent) : void
      {
         var i:int = 0;
         var info:* = null;
         var pkg:PackageIn = evt.pkg;
         _isMySelf = pkg.readBoolean();
         var count:int = pkg.readInt();
         tempArr = new Vector.<AwardsInfo>();
         for(i = 0; i < count; )
         {
            info = new AwardsInfo();
            info.name = pkg.readUTF();
            info.TemplateId = pkg.readInt();
            info.count = pkg.readInt();
            info.zoneID = pkg.readInt();
            info.isLong = pkg.readBoolean();
            if(info.isLong)
            {
               info.zone = pkg.readUTF();
            }
            tempArr.push(info);
            i++;
         }
         if(_isMySelf)
         {
            CaddyModel.instance.clearAwardsList();
         }
         if(CaddyModel.instance.type == 10)
         {
            CaddyModel.instance.addBlessInfoByArr(tempArr);
         }
      }
      
      private function removeListChildEvent() : void
      {
         var i:int = 0;
         for(i = 0; i < _list.numChildren; i++)
         {
         }
      }
      
      private function _awardsChange(e:Event) : void
      {
         var i:int = 0;
         removeListChildEvent();
         _list.disposeAllChildren();
         for(i = 0; i < CaddyModel.instance.awardsList.length; )
         {
            addItem(CaddyModel.instance.awardsList[i]);
            i++;
         }
         _panel.invalidateViewport(true);
         _panel.vScrollbar.scrollValue = 0;
      }
      
      private function _showLinkGoodsInfo(e:CaddyEvent) : void
      {
         _goodTipPos.x = e.point.x;
         _goodTipPos.y = e.point.y;
         showLinkGoodsInfo(e.itemTemplateInfo);
      }
      
      private function showLinkGoodsInfo(item:ItemTemplateInfo, tipStageClickCount:uint = 0) : void
      {
         if(item.CategoryID == 18)
         {
            if(_cardTip == null)
            {
               _cardTip = new CardBoxTipPanel();
            }
            _cardTip.tipData = item;
            setTipPos(_cardTip);
         }
         else
         {
            if(!_goodTip)
            {
               _goodTip = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTip");
            }
            _goodTip.showTip(item);
            setTipPos(_goodTip);
         }
         _tipStageClickCount = tipStageClickCount;
      }
      
      private function setTipPos(tip:BaseTip) : void
      {
         tip.x = _goodTipPos.x - tip.width;
         tip.y = _goodTipPos.y - tip.height - 10;
         if(tip.y < 0)
         {
            tip.y = 10;
         }
         StageReferance.stage.addChild(tip);
         StageReferance.stage.addEventListener("click",__stageClickHandler);
      }
      
      private function __stageClickHandler(event:MouseEvent) : void
      {
         event.stopImmediatePropagation();
         event.stopPropagation();
         if(_tipStageClickCount > 0)
         {
            if(_goodTip)
            {
               _goodTip.parent.removeChild(_goodTip);
            }
            if(_cardTip)
            {
               _cardTip.parent.removeChild(_cardTip);
            }
            if(StageReferance.stage)
            {
               StageReferance.stage.removeEventListener("click",__stageClickHandler);
            }
         }
         else
         {
            _tipStageClickCount = Number(_tipStageClickCount) + 1;
         }
      }
      
      public function addItem(info:AwardsInfo) : void
      {
         var item:AwardsItem = new AwardsItem();
         item.info = info;
         item.addEventListener("goods_click_awardsItem",_showLinkGoodsInfo);
         _list.addChild(item);
      }
      
      public function update() : void
      {
         if(!_isMySelf)
         {
            CaddyModel.instance.addBlessInfoByArr(tempArr);
            _isMySelf = true;
         }
      }
      
      public function dispose() : void
      {
         removeListChildEvent();
         removeEvents();
         if(_bg1)
         {
            ObjectUtils.disposeObject(_bg1);
         }
         _bg1 = null;
         if(_bg2)
         {
            ObjectUtils.disposeObject(_bg2);
         }
         _bg2 = null;
         if(_node)
         {
            ObjectUtils.disposeObject(_node);
         }
         _node = null;
         if(_list)
         {
            ObjectUtils.disposeObject(_list);
         }
         _list = null;
         if(_panel)
         {
            ObjectUtils.disposeObject(_panel);
         }
         _panel = null;
         _goodTipPos = null;
         tempArr = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

package treasureHunting.views
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.tip.BaseTip;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.PkgEvent;
   import ddt.manager.SocketManager;
   import ddt.view.caddyII.CaddyEvent;
   import ddt.view.caddyII.CaddyModel;
   import ddt.view.caddyII.reader.AwardsInfo;
   import ddt.view.caddyII.reader.AwardsItem;
   import ddt.view.tips.CardBoxTipPanel;
   import ddt.view.tips.GoodTip;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import road7th.comm.PackageIn;
   
   public class TreasureRecordView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      protected var _list:VBox;
      
      protected var _panel:ScrollPanel;
      
      private var _goodTip:GoodTip;
      
      private var _cardTip:CardBoxTipPanel;
      
      private var _itemArr:Array;
      
      private var _isMySelf:Boolean;
      
      private var tempArr:Vector.<AwardsInfo>;
      
      protected var _goodTipPos:Point;
      
      private var _tipStageClickCount:int;
      
      public function TreasureRecordView()
      {
         super();
         initView();
         initEvents();
         CaddyModel.instance.setup(15);
         SocketManager.Instance.out.sendRequestAwards(15);
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creat("treasureHunting.recordBG");
         addChild(_bg);
         _list = ComponentFactory.Instance.creatComponentByStylename("treasureHunting.recordVBox");
         _panel = ComponentFactory.Instance.creatComponentByStylename("treasureHunting.recordScrollpanel");
         _panel.setView(_list);
         addChild(_panel);
         _panel.invalidateViewport(true);
         _goodTipPos = new Point();
      }
      
      private function initEvents() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(245),_getAwards);
         CaddyModel.instance.addEventListener("treasure_change",_awardsChange);
      }
      
      private function removeEvents() : void
      {
         SocketManager.Instance.removeEventListener(PkgEvent.format(245),_getAwards);
         CaddyModel.instance.removeEventListener("treasure_change",_awardsChange);
      }
      
      protected function _getAwards(event:PkgEvent) : void
      {
         var i:int = 0;
         var info:* = null;
         var pkg:PackageIn = event.pkg;
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
         if(CaddyModel.instance.type == 15)
         {
            CaddyModel.instance.addTreasureInfoByArr(tempArr);
         }
      }
      
      private function _awardsChange(e:Event) : void
      {
         var i:int = 0;
         _list.disposeAllChildren();
         _itemArr = [];
         for(i = 0; i < CaddyModel.instance.awardsList.length; )
         {
            addItem(CaddyModel.instance.awardsList[i]);
            i++;
         }
         _panel.invalidateViewport(true);
         _panel.vScrollbar.scrollValue = 0;
      }
      
      public function addItem(info:AwardsInfo) : void
      {
         var item:AwardsItem = new AwardsItem();
         item.setTextFieldWidth(180);
         item.info = info;
         item.addEventListener("goods_click_awardsItem",_showLinkGoodsInfo);
         _list.addChild(item);
         _itemArr.push(item);
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
      
      public function dispose() : void
      {
         removeEvents();
         var _loc3_:int = 0;
         var _loc2_:* = _itemArr;
         for each(var item in _itemArr)
         {
            item.removeEventListener("goods_click_awardsItem",_showLinkGoodsInfo);
            ObjectUtils.disposeObject(item);
            item = null;
         }
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_list);
         _list = null;
         ObjectUtils.disposeObject(_panel);
         _panel = null;
         ObjectUtils.disposeObject(_goodTip);
         _goodTip = null;
         ObjectUtils.disposeObject(_cardTip);
         _cardTip = null;
      }
   }
}

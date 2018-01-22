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
      
      protected function _getAwards(param1:PkgEvent) : void
      {
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc3_:PackageIn = param1.pkg;
         _isMySelf = _loc3_.readBoolean();
         var _loc2_:int = _loc3_.readInt();
         tempArr = new Vector.<AwardsInfo>();
         _loc5_ = 0;
         while(_loc5_ < _loc2_)
         {
            _loc4_ = new AwardsInfo();
            _loc4_.name = _loc3_.readUTF();
            _loc4_.TemplateId = _loc3_.readInt();
            _loc4_.count = _loc3_.readInt();
            _loc4_.zoneID = _loc3_.readInt();
            _loc4_.isLong = _loc3_.readBoolean();
            if(_loc4_.isLong)
            {
               _loc4_.zone = _loc3_.readUTF();
            }
            tempArr.push(_loc4_);
            _loc5_++;
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
      
      private function _awardsChange(param1:Event) : void
      {
         var _loc2_:int = 0;
         _list.disposeAllChildren();
         _itemArr = [];
         _loc2_ = 0;
         while(_loc2_ < CaddyModel.instance.awardsList.length)
         {
            addItem(CaddyModel.instance.awardsList[_loc2_]);
            _loc2_++;
         }
         _panel.invalidateViewport(true);
         _panel.vScrollbar.scrollValue = 0;
      }
      
      public function addItem(param1:AwardsInfo) : void
      {
         var _loc2_:AwardsItem = new AwardsItem();
         _loc2_.setTextFieldWidth(180);
         _loc2_.info = param1;
         _loc2_.addEventListener("goods_click_awardsItem",_showLinkGoodsInfo);
         _list.addChild(_loc2_);
         _itemArr.push(_loc2_);
      }
      
      private function _showLinkGoodsInfo(param1:CaddyEvent) : void
      {
         _goodTipPos.x = param1.point.x;
         _goodTipPos.y = param1.point.y;
         showLinkGoodsInfo(param1.itemTemplateInfo);
      }
      
      private function showLinkGoodsInfo(param1:ItemTemplateInfo, param2:uint = 0) : void
      {
         if(param1.CategoryID == 18)
         {
            if(_cardTip == null)
            {
               _cardTip = new CardBoxTipPanel();
            }
            _cardTip.tipData = param1;
            setTipPos(_cardTip);
         }
         else
         {
            if(!_goodTip)
            {
               _goodTip = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTip");
            }
            _goodTip.showTip(param1);
            setTipPos(_goodTip);
         }
         _tipStageClickCount = param2;
      }
      
      private function setTipPos(param1:BaseTip) : void
      {
         param1.x = _goodTipPos.x - param1.width;
         param1.y = _goodTipPos.y - param1.height - 10;
         if(param1.y < 0)
         {
            param1.y = 10;
         }
         StageReferance.stage.addChild(param1);
         StageReferance.stage.addEventListener("click",__stageClickHandler);
      }
      
      private function __stageClickHandler(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         param1.stopPropagation();
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
         for each(var _loc1_ in _itemArr)
         {
            _loc1_.removeEventListener("goods_click_awardsItem",_showLinkGoodsInfo);
            ObjectUtils.disposeObject(_loc1_);
            _loc1_ = null;
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

package ddQiYuan.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddQiYuan.DDQiYuanManager;
   import ddQiYuan.model.DDQiYuanModel;
   import ddt.events.CEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   
   public class AreaRankSp extends Sprite implements Disposeable
   {
       
      
      private const CLICK_INVAL_TIME:int = 1000;
      
      private var _areaRankBtnGroup:SelectedButtonGroup;
      
      private var _myAreaRankBtn:SelectedButton;
      
      private var _allAreaRankBtn:SelectedButton;
      
      private var _itemList:Vector.<AreaRankListItem>;
      
      private var _list:VBox;
      
      private var _panel:ScrollPanel;
      
      private var _model:DDQiYuanModel;
      
      private var _lastClickTime:int;
      
      public function AreaRankSp()
      {
         super();
         initView();
         initEvent();
         _areaRankBtnGroup.selectIndex = 0;
      }
      
      private function initView() : void
      {
         _model = DDQiYuanManager.instance.model;
         _lastClickTime = 0;
         _myAreaRankBtn = ComponentFactory.Instance.creatComponentByStylename("ddQiYuan.myAreaRankBtn");
         addChild(_myAreaRankBtn);
         _allAreaRankBtn = ComponentFactory.Instance.creatComponentByStylename("ddQiYuan.allAreaRankBtn");
         addChild(_allAreaRankBtn);
         _areaRankBtnGroup = new SelectedButtonGroup();
         _areaRankBtnGroup.addSelectItem(_myAreaRankBtn);
         _areaRankBtnGroup.addSelectItem(_allAreaRankBtn);
         _list = new VBox();
         _list.spacing = 1;
         _panel = ComponentFactory.Instance.creatComponentByStylename("ddQiYuan.areaRankScrollPanel");
         _panel.setView(_list);
         addChild(_panel);
         var _loc1_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("ddQiYuan.rankRewardConTipsTf");
         _loc1_.text = LanguageMgr.GetTranslation("ddQiYuan.frame.rankRewardConTips",_model.rankRewardLeastOfferTimes);
         addChild(_loc1_);
      }
      
      private function changeView(param1:Event) : void
      {
         if(_areaRankBtnGroup.selectIndex == 0)
         {
            SocketManager.Instance.out.queryDDQiYuanAreaRank(0);
         }
         else
         {
            SocketManager.Instance.out.queryDDQiYuanAreaRank(1);
         }
      }
      
      private function updateList() : void
      {
         var _loc1_:* = null;
         var _loc3_:int = 0;
         var _loc2_:* = null;
         _list.removeAllChild();
         if(_areaRankBtnGroup.selectIndex == 0)
         {
            _loc1_ = _model.myAreaRankArr;
         }
         else
         {
            _loc1_ = _model.allAreaRankArr;
         }
         if(_loc1_)
         {
            _loc3_ = 0;
            while(_loc3_ < _loc1_.length)
            {
               _loc2_ = new AreaRankListItem();
               _loc2_.setData(_areaRankBtnGroup.selectIndex,_loc3_);
               _list.addChild(_loc2_);
               _loc3_++;
            }
         }
         _panel.invalidateViewport();
      }
      
      private function initEvent() : void
      {
         _myAreaRankBtn.addEventListener("click",onClickBtn,false,2147483647);
         _allAreaRankBtn.addEventListener("click",onClickBtn,false,2147483647);
         _areaRankBtnGroup.addEventListener("change",changeView);
         DDQiYuanManager.instance.addEventListener("event_query_area_rank_back",onQueryAreaRankBack);
      }
      
      private function removeEvent() : void
      {
         _myAreaRankBtn.removeEventListener("click",onClickBtn);
         _allAreaRankBtn.removeEventListener("click",onClickBtn);
         _areaRankBtnGroup.removeEventListener("change",changeView);
         DDQiYuanManager.instance.removeEventListener("event_query_area_rank_back",onQueryAreaRankBack);
      }
      
      private function onClickBtn(param1:MouseEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:SelectedButton = param1.target as SelectedButton;
         if(_areaRankBtnGroup.getItemByIndex(_areaRankBtnGroup.selectIndex) != _loc2_)
         {
            _loc3_ = getTimer();
            if(_loc3_ - _lastClickTime > 1000)
            {
               _lastClickTime = _loc3_;
            }
            else
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.common.clickTooOften"));
               param1.stopImmediatePropagation();
            }
         }
      }
      
      private function onQueryAreaRankBack(param1:CEvent) : void
      {
         var _loc2_:int = param1.data as int;
         updateList();
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         _areaRankBtnGroup = null;
         _myAreaRankBtn = null;
         _allAreaRankBtn = null;
         _itemList = null;
         _list = null;
         _panel = null;
         _model = null;
      }
   }
}

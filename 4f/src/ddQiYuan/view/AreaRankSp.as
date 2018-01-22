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
      
      public function AreaRankSp(){super();}
      
      private function initView() : void{}
      
      private function changeView(param1:Event) : void{}
      
      private function updateList() : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function onClickBtn(param1:MouseEvent) : void{}
      
      private function onQueryAreaRankBack(param1:CEvent) : void{}
      
      public function dispose() : void{}
   }
}

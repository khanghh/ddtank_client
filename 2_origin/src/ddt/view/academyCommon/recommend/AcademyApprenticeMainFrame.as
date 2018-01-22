package ddt.view.academyCommon.recommend
{
   import academy.AcademyManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.AcademyPlayerInfo;
   import ddt.manager.AcademyFrameManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SharedManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   
   public class AcademyApprenticeMainFrame extends BaseAlerFrame implements Disposeable
   {
      
      public static const MAX_ITEM:int = 3;
      
      public static const BOTTOM_GAP:int = 11;
       
      
      protected var _recommendTitle:Bitmap;
      
      protected var _playerContainer:HBox;
      
      protected var _titleBtn:TextButton;
      
      protected var _alertInfo:AlertInfo;
      
      protected var _items:Array;
      
      protected var _players:Vector.<AcademyPlayerInfo>;
      
      protected var _treeImage:ScaleBitmapImage;
      
      protected var _treeImage2:Scale9CornerImage;
      
      protected var _currentItem:RecommendPlayerCellView;
      
      protected var _checkBoxBtn:SelectedCheckButton;
      
      public function AcademyApprenticeMainFrame()
      {
         super();
         initContent();
         initPlayerContainer();
         initEvent();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,1);
      }
      
      protected function initContent() : void
      {
         _alertInfo = new AlertInfo();
         _alertInfo.bottomGap = 11;
         _alertInfo.customPos = ComponentFactory.Instance.creatCustomObject("academyCommon.myAcademy.gotoMainlPos");
         info = _alertInfo;
         info.title = LanguageMgr.GetTranslation("ddt.view.academyCommon.recommend.AcademyApprenticeMainFrame.title");
         _treeImage = ComponentFactory.Instance.creatComponentByStylename("AcademyApprenticeMainFrame.scale9cornerImageTree");
         addToContent(_treeImage);
         _treeImage2 = ComponentFactory.Instance.creatComponentByStylename("AcademyApprenticeMainFrame.scale9cornerImageTree2");
         addToContent(_treeImage2);
         _recommendTitle = ComponentFactory.Instance.creatBitmap("asset.ddtacademy.recommendTitleAsset");
         addToContent(_recommendTitle);
         _titleBtn = ComponentFactory.Instance.creatComponentByStylename("academyCommon.AcademyApprenticeMainFrame.titleBtn");
         _titleBtn.text = LanguageMgr.GetTranslation("ddt.manager.showAcademyPreviewFrame.masterFree");
         addToContent(_titleBtn);
         _playerContainer = ComponentFactory.Instance.creatComponentByStylename("academyCommon.AcademyApprenticeMainFrame.playerContainer");
         addToContent(_playerContainer);
         _checkBoxBtn = ComponentFactory.Instance.creatComponentByStylename("ddt.view.academyCommon.recommend.AcademyApprenticeMainFrame.checkBoxBtn");
         _checkBoxBtn.text = LanguageMgr.GetTranslation("ddt.view.academyCommon.recommend.AcademyApprenticeMainFrame.checkBoxBtnInfo");
         if(!SharedManager.Instance.isRecommend)
         {
            addToContent(_checkBoxBtn);
         }
      }
      
      protected function initPlayerContainer() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _items = [];
         _loc2_ = 0;
         while(_loc2_ < 3)
         {
            _loc1_ = new RecommendPlayerCellView();
            _loc1_.addEventListener("click",__itemClick);
            _playerContainer.addChild(_loc1_);
            _items.push(_loc1_);
            _loc2_++;
         }
         _players = AcademyManager.Instance.recommendPlayers;
         updateItem();
      }
      
      protected function initEvent() : void
      {
         _titleBtn.addEventListener("click",__titleBtnClick);
         addEventListener("response",__frameEvent);
         _checkBoxBtn.addEventListener("click",__checkBoxBtnClick);
      }
      
      private function __checkBoxBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         SharedManager.Instance.isRecommend = _checkBoxBtn.selected;
         SharedManager.Instance.save();
      }
      
      protected function __itemClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(!_currentItem)
         {
            _currentItem = param1.currentTarget as RecommendPlayerCellView;
         }
         if(_currentItem != param1.currentTarget as RecommendPlayerCellView)
         {
            _currentItem.isSelect = false;
         }
         _currentItem = param1.currentTarget as RecommendPlayerCellView;
         _currentItem.isSelect = true;
      }
      
      protected function __frameEvent(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
               break;
            case 2:
            case 3:
            case 4:
               if(StateManager.currentStateType == "academyRegistration")
               {
                  dispose();
               }
               AcademyManager.Instance.gotoAcademyState();
         }
      }
      
      protected function __titleBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         AcademyFrameManager.Instance.showRecommendAcademyPreviewFrame();
      }
      
      protected function updateItem() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            _items[_loc1_].info = _players[_loc1_];
            _loc1_++;
         }
      }
      
      private function cleanItem() : void
      {
         var _loc1_:int = 0;
         if(!_items)
         {
            return;
         }
         _loc1_ = 0;
         while(_loc1_ < _items.length)
         {
            _items[_loc1_].removeEventListener("click",__itemClick);
            _items[_loc1_].dispose();
            _items[_loc1_] = null;
            _loc1_++;
         }
         _playerContainer.disposeAllChildren();
         _items = null;
      }
      
      override public function dispose() : void
      {
         removeEventListener("response",__frameEvent);
         _currentItem = null;
         cleanItem();
         if(_recommendTitle)
         {
            ObjectUtils.disposeObject(_recommendTitle);
            _recommendTitle = null;
         }
         if(_playerContainer)
         {
            ObjectUtils.disposeObject(_playerContainer);
            _playerContainer = null;
         }
         if(_checkBoxBtn)
         {
            _checkBoxBtn.removeEventListener("click",__checkBoxBtnClick);
            _checkBoxBtn.dispose();
            _checkBoxBtn = null;
         }
         if(_titleBtn)
         {
            _titleBtn.removeEventListener("click",__titleBtnClick);
            ObjectUtils.disposeObject(_titleBtn);
            _titleBtn = null;
         }
         if(_treeImage)
         {
            ObjectUtils.disposeObject(_treeImage);
            _treeImage = null;
         }
         if(_treeImage2)
         {
            ObjectUtils.disposeObject(_treeImage2);
            _treeImage2 = null;
         }
         super.dispose();
      }
   }
}

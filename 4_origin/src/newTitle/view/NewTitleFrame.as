package newTitle.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.SelectedTextButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.EffortEvent;
   import ddt.manager.EffortManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import hall.event.NewHallEvent;
   import newTitle.NewTitleControl;
   import newTitle.NewTitleManager;
   import newTitle.event.NewTitleEvent;
   import newTitle.model.NewTitleModel;
   
   public class NewTitleFrame extends Frame
   {
       
      
      private var _titleBg:Bitmap;
      
      private var _currentTitle:Bitmap;
      
      private var _titleSprite:Sprite;
      
      private var _titleTxt:FilterFrameText;
      
      private var _hideBtn:SelectedCheckButton;
      
      private var _selectedButtonGroup:SelectedButtonGroup;
      
      private var _hasTitleBtn:SelectedTextButton;
      
      private var _allTitleBtn:SelectedTextButton;
      
      private var _titleList:NewTitleListView;
      
      private var _titleBottomBg:MutipleImage;
      
      private var _titleListBg:ScaleBitmapImage;
      
      private var _titleProBg:MutipleImage;
      
      private var _useBtnBg:ScaleBitmapImage;
      
      private var _useBtn:SimpleBitmapButton;
      
      private var _propertyText:FilterFrameText;
      
      private var _oldTitleText:FilterFrameText;
      
      private var _selectTitle:NewTitleModel;
      
      public function NewTitleFrame()
      {
         super();
         initView();
         initEvent();
         updateTitleList();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("newTitleView.titleTxt");
         _titleBg = ComponentFactory.Instance.creat("asset.newTitle.titleBg");
         addToContent(_titleBg);
         _titleTxt = ComponentFactory.Instance.creatComponentByStylename("newTitle.currentTitleTxt");
         _titleTxt.text = LanguageMgr.GetTranslation("newTitleView.currentTitleTxt");
         addToContent(_titleTxt);
         _titleBottomBg = ComponentFactory.Instance.creatComponentByStylename("newTitle.titleBottomBg");
         addToContent(_titleBottomBg);
         _hasTitleBtn = ComponentFactory.Instance.creatComponentByStylename("newTitle.hasTitleBtn");
         _hasTitleBtn.text = LanguageMgr.GetTranslation("newTitleView.hasTitleTxt");
         addToContent(_hasTitleBtn);
         _allTitleBtn = ComponentFactory.Instance.creatComponentByStylename("newTitle.allTitleBtn");
         _allTitleBtn.text = LanguageMgr.GetTranslation("newTitleView.allTitleTxt");
         addToContent(_allTitleBtn);
         _hideBtn = ComponentFactory.Instance.creatComponentByStylename("newTitle.hideBtn");
         _hideBtn.tipData = LanguageMgr.GetTranslation("newTitleView.hideBtnTipTxt");
         _hideBtn.selected = !NewTitleManager.instance.ShowTitle;
         addToContent(_hideBtn);
         _titleListBg = ComponentFactory.Instance.creatComponentByStylename("newTitle.titleListBg");
         addToContent(_titleListBg);
         _titleProBg = ComponentFactory.Instance.creatComponentByStylename("newTitle.titleProBg");
         addToContent(_titleProBg);
         creatTitleSprite();
         _titleList = new NewTitleListView();
         PositionUtils.setPos(_titleList,"newTitle.listPos");
         addToContent(_titleList);
         _propertyText = ComponentFactory.Instance.creatComponentByStylename("newTitle.propertyText");
         addToContent(_propertyText);
         _oldTitleText = ComponentFactory.Instance.creatComponentByStylename("newTitle.titleText");
         loadIcon(NewTitleManager.instance.titleInfo[PlayerManager.Instance.Self.honorId]);
         _useBtnBg = ComponentFactory.Instance.creatComponentByStylename("newTitle.useBtnBG");
         addToContent(_useBtnBg);
         _useBtn = ComponentFactory.Instance.creatComponentByStylename("newTitle.useBtn");
         addToContent(_useBtn);
         _selectedButtonGroup = new SelectedButtonGroup();
         _selectedButtonGroup.addSelectItem(_hasTitleBtn);
         _selectedButtonGroup.addSelectItem(_allTitleBtn);
         _selectedButtonGroup.selectIndex = 0;
      }
      
      private function creatTitleSprite() : void
      {
         _titleSprite = new Sprite();
         _titleSprite.graphics.beginFill(0,0);
         _titleSprite.graphics.drawRect(0,0,_titleProBg.width,70);
         _titleSprite.graphics.endFill();
         addToContent(_titleSprite);
         PositionUtils.setPos(_titleSprite,_titleProBg);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameEventHandler);
         _hideBtn.addEventListener("click",__onHideTitleClick);
         _selectedButtonGroup.addEventListener("change",__onSelectChange);
         _useBtn.addEventListener("click",__onUseClick);
         EffortManager.Instance.addEventListener("finish",__upadteTitle);
         NewTitleControl.instance.addEventListener("titleItemClick",__onItemClick);
         NewTitleManager.instance.addEventListener("setSelectTitle",__onSetSelectTitleForCurrent);
      }
      
      private function updateTitleList() : void
      {
         _titleList.updateOwnTitleList();
      }
      
      public function __onSetSelectTitleForCurrent(param1:NewTitleEvent) : void
      {
         ObjectUtils.disposeObject(_currentTitle);
         _currentTitle = null;
         loadIcon(_selectTitle);
      }
      
      protected function __onUseClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_selectTitle)
         {
            ObjectUtils.disposeAllChildren(_titleSprite);
            loadIcon(_selectTitle);
            NewTitleManager.instance.dispatchEvent(new NewTitleEvent("selectTitle",[_selectTitle.Name]));
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("newTitleView.selectTitleTxt"));
         }
      }
      
      protected function __onHideTitleClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         NewTitleManager.instance.ShowTitle = !_hideBtn.selected;
         SocketManager.Instance.out.showHideTitleState(_hideBtn.selected);
         SocketManager.Instance.dispatchEvent(new NewHallEvent("newhallupdatetitle"));
      }
      
      protected function __onItemClick(param1:NewTitleEvent) : void
      {
         SoundManager.instance.play("008");
         if(_selectedButtonGroup.selectIndex == 0)
         {
            _selectTitle = EffortManager.Instance.getHonorArray()[param1.data[0]];
            _useBtn.enable = true;
         }
         else
         {
            _selectTitle = NewTitleManager.instance.titleArray[param1.data[0]];
            _useBtn.enable = isOwnTitle(_selectTitle.Name);
         }
         setPropertyText();
         ObjectUtils.disposeAllChildren(_titleSprite);
         loadIcon(_selectTitle);
      }
      
      private function setPropertyText() : void
      {
         var _loc1_:String = "";
         _propertyText.text = LanguageMgr.GetTranslation("newTitleView.propertyTxt",_selectTitle.Att,_selectTitle.Def,_selectTitle.Agi,_selectTitle.Luck,_selectTitle.Valid,_selectTitle.Desc);
         if(_selectTitle.Valid <= 0)
         {
            _loc1_ = LanguageMgr.GetTranslation("newTitleView.hasnoTitleTxt");
         }
         else if(_selectTitle.Valid > 1825)
         {
            _loc1_ = LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.use");
         }
         if(_loc1_.length > 0)
         {
            _propertyText.text = _propertyText.text.replace(_selectTitle.Valid + LanguageMgr.GetTranslation("day"),_loc1_);
         }
      }
      
      private function isOwnTitle(param1:String) : Boolean
      {
         var _loc4_:int = 0;
         var _loc2_:Boolean = false;
         var _loc3_:Array = EffortManager.Instance.getHonorArray();
         _loc4_ = 0;
         while(_loc4_ < _loc3_.length)
         {
            if(param1 == _loc3_[_loc4_].Name)
            {
               _loc2_ = true;
               break;
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      private function loadIcon(param1:NewTitleModel) : void
      {
         var _loc2_:* = null;
         if(param1 && param1.Pic && param1.Pic != "0")
         {
            _loc2_ = LoadResourceManager.Instance.createLoader(PathManager.solvePath("image/title/" + param1.Pic + "/icon.png"),0);
            _loc2_.addEventListener("complete",__onComplete);
            LoadResourceManager.Instance.startLoad(_loc2_,true);
         }
         else if(param1)
         {
            _oldTitleText.text = param1.Name;
            _oldTitleText.x = (_titleSprite.width - _oldTitleText.width) / 2;
            _oldTitleText.y = (_titleSprite.height - _oldTitleText.height) / 2;
            _titleSprite.addChild(_oldTitleText);
         }
      }
      
      protected function __onComplete(param1:LoaderEvent) : void
      {
         var _loc3_:BaseLoader = param1.loader;
         _loc3_.removeEventListener("complete",__onComplete);
         var _loc2_:Bitmap = _loc3_.content;
         if(_loc2_)
         {
            if(!_currentTitle && PlayerManager.Instance.Self.honorId >= NewTitleManager.FIRST_TITLEID)
            {
               _currentTitle = new Bitmap(_loc2_.bitmapData.clone());
               _currentTitle.x = _titleBg.x + (_titleBg.width - _currentTitle.width) / 2;
               _currentTitle.y = _titleBg.y + (_titleBg.height - _currentTitle.height) / 2;
               addToContent(_currentTitle);
            }
            else
            {
               _loc2_.x = (_titleSprite.width - _loc2_.width) / 2;
               _loc2_.y = (_titleSprite.height - _loc2_.height) / 2;
               _titleSprite.addChild(_loc2_);
            }
         }
      }
      
      protected function __onSelectChange(param1:Event) : void
      {
         SoundManager.instance.play("008");
         switch(int(_selectedButtonGroup.selectIndex))
         {
            case 0:
               _titleList.updateOwnTitleList();
               break;
            case 1:
               _titleList.updateAllTitleList();
         }
      }
      
      private function __upadteTitle(param1:EffortEvent) : void
      {
         if(_selectedButtonGroup.selectIndex == 0)
         {
            _titleList.updateOwnTitleList();
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,2,true,1);
      }
      
      private function __frameEventHandler(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               NewTitleControl.instance.hide();
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameEventHandler);
         _hideBtn.removeEventListener("click",__onHideTitleClick);
         _selectedButtonGroup.removeEventListener("change",__onSelectChange);
         _useBtn.removeEventListener("click",__onUseClick);
         NewTitleControl.instance.removeEventListener("titleItemClick",__onItemClick);
         NewTitleManager.instance.removeEventListener("setSelectTitle",__onSetSelectTitleForCurrent);
         EffortManager.Instance.removeEventListener("finish",__upadteTitle);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEvent();
         ObjectUtils.disposeObject(_titleBg);
         _titleBg = null;
         ObjectUtils.disposeAllChildren(_titleSprite);
         _titleSprite = null;
         ObjectUtils.disposeObject(_titleTxt);
         _titleTxt = null;
         ObjectUtils.disposeObject(_titleBottomBg);
         _titleBottomBg = null;
         ObjectUtils.disposeObject(_titleListBg);
         _titleListBg = null;
         ObjectUtils.disposeObject(_titleProBg);
         _titleProBg = null;
         ObjectUtils.disposeObject(_hideBtn);
         _hideBtn = null;
         ObjectUtils.disposeObject(_useBtnBg);
         _useBtnBg = null;
         ObjectUtils.disposeObject(_useBtn);
         _useBtn = null;
         ObjectUtils.disposeObject(_hasTitleBtn);
         _hasTitleBtn = null;
         ObjectUtils.disposeObject(_propertyText);
         _propertyText = null;
         ObjectUtils.disposeObject(_oldTitleText);
         _oldTitleText = null;
         ObjectUtils.disposeObject(_allTitleBtn);
         _allTitleBtn = null;
         ObjectUtils.disposeObject(_titleList);
         _titleList = null;
         ObjectUtils.disposeObject(_currentTitle);
         _currentTitle = null;
      }
   }
}

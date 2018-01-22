package sevenday.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.quest.QuestInfo;
   import ddt.events.PkgEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import quest.TaskManager;
   import road7th.comm.PackageIn;
   import sevenday.SevendayManager;
   
   public class SevendayMainFrame extends Frame
   {
       
      
      private var _bg:Bitmap;
      
      private var _title:Bitmap;
      
      private var _dayHBox:HBox;
      
      private var _dayBtnGroup:SelectedButtonGroup;
      
      private var _smalltitle:ScaleFrameImage;
      
      private var _baseBtn:SelectedButton;
      
      private var _superBtn:SelectedButton;
      
      private var _targetBtnGroup:SelectedButtonGroup;
      
      private var _sevendayTaskLeftView:SevendayTaskLeftView;
      
      private var _endTimeText:FilterFrameText;
      
      private var _completeText:FilterFrameText;
      
      private var _upgradeText:FilterFrameText;
      
      private var _targetCompleteText:FilterFrameText;
      
      private var _progress:SevendayTaskProgress;
      
      private var _helpBtn:SimpleBitmapButton;
      
      private var _contentArr:Array;
      
      public function SevendayMainFrame()
      {
         super();
         initview();
         initEvent();
         SocketManager.Instance.out.getSevendayProgressCount();
         _dayBtnGroup.selectIndex = SevendayManager.instance.day;
         _targetBtnGroup.selectIndex = 0;
      }
      
      private function initview() : void
      {
         var _loc9_:int = 0;
         var _loc2_:* = null;
         var _loc7_:* = false;
         var _loc3_:* = null;
         var _loc4_:int = 0;
         var _loc6_:* = null;
         var _loc1_:* = null;
         var _loc5_:int = 0;
         _bg = ComponentFactory.Instance.creatBitmap("asset.sevenday.bg");
         addToContent(_bg);
         _title = ComponentFactory.Instance.creatBitmap("asset.sevenday.title");
         addToContent(_title);
         _dayHBox = ComponentFactory.Instance.creatComponentByStylename("sevendayHBox");
         addToContent(_dayHBox);
         _dayBtnGroup = new SelectedButtonGroup();
         _loc9_ = 0;
         while(_loc9_ < 7)
         {
            _loc2_ = ComponentFactory.Instance.creatComponentByStylename("ddt.sevenday.dayBtn" + _loc9_);
            _loc7_ = _loc9_ <= SevendayManager.instance.day;
            _loc2_.enable = _loc7_;
            _dayBtnGroup.addSelectItem(_loc2_);
            _dayHBox.addChild(_loc2_);
            _loc9_++;
         }
         _smalltitle = ComponentFactory.Instance.creatComponentByStylename("ddt.sevenday.smalltitle");
         addToContent(_smalltitle);
         _targetBtnGroup = new SelectedButtonGroup();
         _baseBtn = ComponentFactory.Instance.creatComponentByStylename("ddt.sevenday.basebtn");
         _targetBtnGroup.addSelectItem(_baseBtn);
         addToContent(_baseBtn);
         _superBtn = ComponentFactory.Instance.creatComponentByStylename("ddt.sevenday.superbtn");
         _targetBtnGroup.addSelectItem(_superBtn);
         addToContent(_superBtn);
         _sevendayTaskLeftView = new SevendayTaskLeftView();
         addToContent(_sevendayTaskLeftView);
         _endTimeText = ComponentFactory.Instance.creatComponentByStylename("sevenday.text1");
         addToContent(_endTimeText);
         _completeText = ComponentFactory.Instance.creatComponentByStylename("sevenday.text2");
         _completeText.htmlText = LanguageMgr.GetTranslation("ddt.sevenday.text2");
         addToContent(_completeText);
         _upgradeText = ComponentFactory.Instance.creatComponentByStylename("sevenday.text3");
         _upgradeText.htmlText = LanguageMgr.GetTranslation("ddt.sevenday.text3");
         addToContent(_upgradeText);
         _targetCompleteText = ComponentFactory.Instance.creatComponentByStylename("sevenday.text4");
         _targetCompleteText.htmlText = LanguageMgr.GetTranslation("ddt.sevenday.text4");
         addToContent(_targetCompleteText);
         _progress = ComponentFactory.Instance.creatComponentByStylename("ddt.sevenday.taskprogress");
         addToContent(_progress);
         _contentArr = [];
         var _loc8_:Array = ServerConfigManager.instance.sevendayProgressGift;
         _loc9_ = 0;
         while(_loc9_ < 3)
         {
            _loc3_ = String(_loc8_[_loc9_]).split(",");
            _loc4_ = _loc3_[0];
            _loc6_ = ItemManager.Instance.getTemplateById(int(_loc3_[1])).Description;
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("ddt.sevenday.content" + _loc9_);
            _loc1_.addChild(ComponentFactory.Instance.creatBitmap("asset.sevenday.gift" + (_loc9_ + 1)));
            _loc1_.tipData = LanguageMgr.GetTranslation("tank.sevenday.gift",_loc4_,_loc6_);
            addToContent(_loc1_);
            _contentArr[_loc9_] = _loc1_;
            _loc9_++;
         }
         if(SevendayManager.instance.day <= 5)
         {
            _loc5_ = 7 - SevendayManager.instance.day - 1;
            _endTimeText.text = LanguageMgr.GetTranslation("ddt.sevenday.text1",_loc5_);
         }
         else
         {
            _endTimeText.text = LanguageMgr.GetTranslation("ddt.sevenday.text5",SevendayManager.instance.hour);
         }
         _helpBtn = HelpFrameUtils.Instance.simpleHelpButton(this,"sevenday.button.helpBtn",null,LanguageMgr.GetTranslation("store.view.HelpButtonText"),"asset.sevenday.helpText",404,484) as SimpleBitmapButton;
         PositionUtils.setPos(_helpBtn,"sevenday.helpBtnPos");
         addToContent(_helpBtn);
      }
      
      private function initEvent() : void
      {
         _dayBtnGroup.addEventListener("change",___onDayBtnChangeHandler);
         _targetBtnGroup.addEventListener("change",__onTargetBtnChangeHandler);
         SocketManager.Instance.addEventListener(PkgEvent.format(363,1),__onGetProgressCount);
      }
      
      private function __onGetProgressCount(param1:PkgEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         var _loc2_:int = _loc3_.readInt();
         _progress.setProgress(_loc2_,105);
      }
      
      private function __onTargetBtnChangeHandler(param1:Event) : void
      {
         SoundManager.instance.playButtonSound();
         updateView();
      }
      
      private function updateView() : void
      {
         var _loc4_:Array = [SevendayManager.QUEST_LIST_1,SevendayManager.QUEST_LIST_2];
         var _loc2_:Array = _loc4_[_targetBtnGroup.selectIndex];
         var _loc1_:int = _loc2_[_dayBtnGroup.selectIndex];
         var _loc3_:QuestInfo = TaskManager.instance.getQuestByID(_loc1_);
         _sevendayTaskLeftView.update(_loc3_);
      }
      
      private function removeEvent() : void
      {
         SocketManager.Instance.removeEventListener(PkgEvent.format(363,1),__onGetProgressCount);
         _dayBtnGroup.removeEventListener("change",___onDayBtnChangeHandler);
         _targetBtnGroup.removeEventListener("change",__onTargetBtnChangeHandler);
      }
      
      private function ___onDayBtnChangeHandler(param1:Event) : void
      {
         SoundManager.instance.playButtonSound();
         _smalltitle.setFrame(_dayBtnGroup.selectIndex + 1);
         if(_targetBtnGroup.selectIndex == 0)
         {
            updateView();
         }
         else
         {
            _targetBtnGroup.selectIndex = 0;
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,1);
      }
      
      override protected function onFrameClose() : void
      {
         SoundManager.instance.playButtonSound();
         SevendayManager.instance.hideFrame();
      }
      
      override public function dispose() : void
      {
         var _loc1_:* = null;
         removeEvent();
         while(_contentArr.length)
         {
            _loc1_ = _contentArr.pop();
            ObjectUtils.disposeAllChildren(_loc1_);
            ObjectUtils.disposeObject(_loc1_);
         }
         _contentArr = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_title);
         _title = null;
         ObjectUtils.disposeObject(_dayBtnGroup);
         _dayBtnGroup = null;
         ObjectUtils.disposeObject(_dayHBox);
         _dayHBox = null;
         ObjectUtils.disposeObject(_smalltitle);
         _smalltitle = null;
         ObjectUtils.disposeObject(_targetBtnGroup);
         _targetBtnGroup = null;
         _superBtn = null;
         _baseBtn = null;
         ObjectUtils.disposeObject(_sevendayTaskLeftView);
         _sevendayTaskLeftView = null;
         ObjectUtils.disposeObject(_endTimeText);
         _endTimeText = null;
         ObjectUtils.disposeObject(_completeText);
         _completeText = null;
         ObjectUtils.disposeObject(_upgradeText);
         _upgradeText = null;
         ObjectUtils.disposeObject(_targetCompleteText);
         _targetCompleteText = null;
         ObjectUtils.disposeObject(_progress);
         _progress = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         super.dispose();
      }
   }
}

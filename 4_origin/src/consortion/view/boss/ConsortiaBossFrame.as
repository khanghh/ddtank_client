package consortion.view.boss
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.guard.ConsortiaGuardControl;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   
   public class ConsortiaBossFrame extends Frame
   {
      
      public static const PAGE_BOSS:int = 0;
      
      public static const PAGE_GUARD:int = 1;
       
      
      private var _bg:Bitmap;
      
      private var _titleText1:FilterFrameText;
      
      private var _titleText2:FilterFrameText;
      
      private var _titleText3:FilterFrameText;
      
      private var _titleText4:FilterFrameText;
      
      private var _titleText5:FilterFrameText;
      
      private var _levelView:ConsortiaBossLevelView;
      
      private var _bossSelectBtn:SelectedButton;
      
      private var _guardSelectBtn:SelectedButton;
      
      private var _group:SelectedButtonGroup;
      
      private var _bossView:ConsortiaBossView;
      
      private var _guardView:ConsortiaGuardBossView;
      
      private var _cellList:Vector.<BossMemberItem>;
      
      public function ConsortiaBossFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         titleText = LanguageMgr.GetTranslation("ddt.consortia.bossFrame.titleTxt");
         _bg = ComponentFactory.Instance.creatBitmap("asset.consortionBossFrame.bg");
         addToContent(_bg);
         _titleText1 = ComponentFactory.Instance.creatComponentByStylename("ddt.consortia.bossFrame.titleText");
         addToContent(_titleText1);
         _titleText2 = ComponentFactory.Instance.creatComponentByStylename("ddt.consortia.bossFrame.titleText");
         addToContent(_titleText2);
         _titleText3 = ComponentFactory.Instance.creatComponentByStylename("ddt.consortia.bossFrame.titleText");
         addToContent(_titleText3);
         _titleText4 = ComponentFactory.Instance.creatComponentByStylename("ddt.consortia.bossFrame.titleText");
         addToContent(_titleText4);
         _titleText5 = ComponentFactory.Instance.creatComponentByStylename("ddt.consortia.bossFrame.titleText");
         addToContent(_titleText5);
         PositionUtils.setPos(_titleText1,"ddt.consortia.bossFrame.titleTextPos1");
         PositionUtils.setPos(_titleText2,"ddt.consortia.bossFrame.titleTextPos2");
         PositionUtils.setPos(_titleText3,"ddt.consortia.bossFrame.titleTextPos3");
         PositionUtils.setPos(_titleText4,"ddt.consortia.bossFrame.titleTextPos4");
         PositionUtils.setPos(_titleText5,"ddt.consortia.bossFrame.titleTextPos5");
         _bossSelectBtn = ComponentFactory.Instance.creatComponentByStylename("consortionBossFrame.bossSelectBtn");
         _guardSelectBtn = ComponentFactory.Instance.creatComponentByStylename("consortionBossFrame.guradSelectBtn");
         _group = new SelectedButtonGroup();
         _group.addSelectItem(_bossSelectBtn);
         _group.addSelectItem(_guardSelectBtn);
         addToContent(_bossSelectBtn);
         addToContent(_guardSelectBtn);
         ConsortiaGuardControl.Instance.model.reset();
         _bossView = new ConsortiaBossView(this);
         _guardView = new ConsortiaGuardBossView(this);
         addToContent(_bossView);
         addToContent(_guardView);
         _levelView = new ConsortiaBossLevelView();
         PositionUtils.setPos(_levelView,"consortiaBoss.levelViewPos");
         addToContent(_levelView);
         _cellList = new Vector.<BossMemberItem>(11);
         _loc2_ = 0;
         while(_loc2_ < 11)
         {
            _loc1_ = new BossMemberItem();
            _loc1_.x = 26;
            _loc1_.y = 96 + _loc2_ * 35;
            _loc1_.visible = false;
            addToContent(_loc1_);
            _cellList[_loc2_] = _loc1_;
            _loc2_++;
         }
         __onChange(null);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
         _group.addEventListener("change",__onChange);
         _group.selectIndex = 0;
      }
      
      private function __onChange(param1:Event) : void
      {
         _levelView.currentFrame = _group.selectIndex;
         _levelView.reset();
         if(_group.selectIndex == 0)
         {
            _titleText1.text = LanguageMgr.GetTranslation("tank.consortiaGurad.bossTitle1");
            _titleText2.text = LanguageMgr.GetTranslation("tank.consortiaGurad.bossTitle2");
            _titleText3.text = LanguageMgr.GetTranslation("tank.consortiaGurad.bossTitle3");
            _titleText4.text = LanguageMgr.GetTranslation("tank.consortiaGurad.bossTitle4");
            _titleText5.text = LanguageMgr.GetTranslation("tank.consortiaGurad.bossTitle5");
            _bossView.show();
            _guardView.hied();
         }
         else if(_group.selectIndex == 1)
         {
            _titleText1.text = LanguageMgr.GetTranslation("tank.consortiaGurad.guardTitle1");
            _titleText2.text = LanguageMgr.GetTranslation("tank.consortiaGurad.guardTitle2");
            _titleText3.text = LanguageMgr.GetTranslation("tank.consortiaGurad.guardTitle3");
            _titleText4.text = LanguageMgr.GetTranslation("tank.consortiaGurad.guardTitle4");
            _titleText5.text = LanguageMgr.GetTranslation("tank.consortiaGurad.guardTitle5");
            _bossView.hied();
            _guardView.show();
         }
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            SoundManager.instance.play("008");
            dispose();
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         _group.removeEventListener("change",__onChange);
      }
      
      public function get levelView() : ConsortiaBossLevelView
      {
         return _levelView;
      }
      
      public function get currentPage() : int
      {
         return _group.selectIndex;
      }
      
      public function get cellList() : Vector.<BossMemberItem>
      {
         return _cellList;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         _group.dispose();
         _group = null;
         ObjectUtils.disposeObject(_bossSelectBtn);
         _bossSelectBtn = null;
         ObjectUtils.disposeObject(_guardSelectBtn);
         _guardSelectBtn = null;
         super.dispose();
         _bg = null;
         _bossView = null;
         _guardView = null;
         _levelView = null;
         _cellList = null;
         _titleText = null;
      }
   }
}

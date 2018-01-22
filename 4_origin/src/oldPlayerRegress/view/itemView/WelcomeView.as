package oldPlayerRegress.view.itemView
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import oldPlayerRegress.RegressControl;
   
   public class WelcomeView extends Frame
   {
       
      
      private var _titleBg:Bitmap;
      
      private var _welTitleImg:ScaleFrameImage;
      
      private var _privilegeBtn:TextButton;
      
      private var _welDescript:FilterFrameText;
      
      private var _firstDesData:FilterFrameText;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _vBox:VBox;
      
      private var _listView:ScrollPanel;
      
      public function WelcomeView()
      {
         super();
         _init();
      }
      
      private function _init() : void
      {
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _titleBg = ComponentFactory.Instance.creat("asset.regress.titleBg");
         _welTitleImg = ComponentFactory.Instance.creatComponentByStylename("regress.WelTitle");
         _privilegeBtn = ComponentFactory.Instance.creatComponentByStylename("regress.privilegeBtn");
         _privilegeBtn.text = LanguageMgr.GetTranslation("ddt.regress.welView.Privilege");
         _welDescript = ComponentFactory.Instance.creatComponentByStylename("regress.Description");
         _welDescript.text = LanguageMgr.GetTranslation("ddt.regress.welView.Descript");
         _firstDesData = ComponentFactory.Instance.creatComponentByStylename("regress.firstDes");
         _firstDesData.mouseEnabled = true;
         _firstDesData.htmlText = RegressControl.instance.updateContent + "";
         addToContent(_titleBg);
         addToContent(_welTitleImg);
         addToContent(_privilegeBtn);
         addToContent(_welDescript);
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("ddtRegress.views.welcomeViewScroll");
         addToContent(_scrollPanel);
         _scrollPanel.setView(_firstDesData);
         _scrollPanel.invalidateViewport();
      }
      
      private function initData() : void
      {
         var _loc4_:int = 0;
         var _loc2_:* = null;
         var _loc1_:* = null;
         var _loc3_:* = null;
         _vBox = new VBox();
         _vBox.spacing = 10;
         _loc4_ = 1;
         while(_loc4_ <= 3)
         {
            _loc2_ = LanguageMgr.GetTranslation("ddt.regress.welView.title" + _loc4_);
            _loc1_ = LanguageMgr.GetTranslation("ddt.regress.welView.descript" + _loc4_);
            _loc3_ = new WelcomeViewItem();
            _loc3_.setData(_loc2_,_loc1_);
            _loc3_.setDesOffset(2,10);
            _vBox.addChild(_loc3_);
            _loc4_++;
         }
         _listView = ComponentFactory.Instance.creat("regress.welListView");
         _listView.setView(_vBox);
         _listView.vScrollProxy = 1;
         _listView.hScrollProxy = 2;
         addToContent(_listView);
      }
      
      private function initEvent() : void
      {
         _privilegeBtn.addEventListener("click",__onPrivilegeClick);
      }
      
      protected function __onPrivilegeClick(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var _loc2_:WelFrameView = ComponentFactory.Instance.creatComponentByStylename("regress.privilegeAssetFrame");
         LayerManager.Instance.addToLayer(_loc2_,2,true,1);
      }
      
      private function removeEvent() : void
      {
         _privilegeBtn.removeEventListener("click",__onPrivilegeClick);
      }
      
      public function show() : void
      {
         this.visible = true;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEvent();
         if(_titleBg)
         {
            _titleBg = null;
         }
         if(_welTitleImg)
         {
            _welTitleImg.dispose();
            _welTitleImg = null;
         }
         if(_privilegeBtn)
         {
            _privilegeBtn.dispose();
            _privilegeBtn = null;
         }
         if(_welDescript)
         {
            _welDescript.dispose();
            _welDescript = null;
         }
         if(_scrollPanel)
         {
            ObjectUtils.disposeAllChildren(_scrollPanel);
            ObjectUtils.disposeObject(_scrollPanel);
            _scrollPanel = null;
         }
      }
   }
}

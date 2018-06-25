package ddt.view.academyCommon.myAcademy
{
   import academy.AcademyManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.vo.AlertInfo;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.LanguageMgr;
   import ddt.utils.PositionUtils;
   import ddt.view.academyCommon.myAcademy.myAcademyItem.MyAcademyClassmateItem;
   import ddt.view.academyCommon.myAcademy.myAcademyItem.MyAcademyMasterItem;
   
   public class MyAcademyApprenticeFrame extends MyAcademyMasterFrame implements Disposeable
   {
       
      
      private var _masterItem:MyAcademyMasterItem;
      
      private var _classmateItem:MyAcademyClassmateItem;
      
      private var _classmateItemII:MyAcademyClassmateItem;
      
      private var _masterInfo:PlayerInfo;
      
      private var _ApprenticeInfos:Vector.<PlayerInfo>;
      
      public function MyAcademyApprenticeFrame()
      {
         super();
      }
      
      override public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,1);
      }
      
      override protected function initContent() : void
      {
         _alertInfo = new AlertInfo();
         _alertInfo.title = LanguageMgr.GetTranslation("im.IMView.myAcademyBtnTips");
         _alertInfo.bottomGap = 27;
         _alertInfo.customPos = ComponentFactory.Instance.creatCustomObject("academyCommon.myAcademy.gotoMainlPos2");
         info = _alertInfo;
         _ItemButtomBg1 = ComponentFactory.Instance.creatComponentByStylename("asset.academyCommon.academyItemButtomBg1");
         addToContent(_ItemButtomBg1);
         _myAcademyTitle = ComponentFactory.Instance.creatBitmap("asset.academyCommon.myAcademy.myAcademyTitle");
         addToContent(_myAcademyTitle);
         _titleBtn = ComponentFactory.Instance.creatComponentByStylename("academyCommon.myAcademy.MyAcademyMasterFrame.titleBtn");
         _titleBtn.text = LanguageMgr.GetTranslation("ddt.manager.showAcademyPreviewFrame.masterFree");
         addToContent(_titleBtn);
         _myApprentice = AcademyManager.Instance.myAcademyPlayers;
         initItem();
      }
      
      override protected function initItem() : void
      {
         _myAcademyIcon = ComponentFactory.Instance.creatBitmap("asset.academyCommon.myAcademy.myAcademyMasterIcon");
         addToContent(_myAcademyIcon);
         _ItemButtomBg2 = ComponentFactory.Instance.creatComponentByStylename("asset.academyCommon.academyItemButtomBg2");
         addToContent(_ItemButtomBg2);
         _itemBG = ComponentFactory.Instance.creatComponentByStylename("asset.academyCommon.myAcademy.myAcademyMasterBG");
         addToContent(_itemBG);
         _nameTitle = ComponentFactory.Instance.creatComponentByStylename("academyCommon.MyAcademyMasterItem.nameTitle");
         _nameTitle.text = LanguageMgr.GetTranslation("ddt.view.academyCommon.academyIcon.MasterIcon");
         addToContent(_nameTitle);
         initItemContent();
         _nameTitleClass = ComponentFactory.Instance.creatComponentByStylename("academyCommon.MyAcademyClassmatesItem.nameTitle");
         _nameTitleClass.text = LanguageMgr.GetTranslation("ddt.view.academyCommon.academyIcon.ClassIcon");
         addToContent(_nameTitleClass);
         _levelTitleClass = ComponentFactory.Instance.creatComponentByStylename("academyCommon.MyAcademyClassmatesItem.levelTitle");
         _levelTitleClass.text = LanguageMgr.GetTranslation("itemview.listlevel");
         addToContent(_levelTitleClass);
         _offLineTitleClass = ComponentFactory.Instance.creatComponentByStylename("academyCommon.MyAcademyClassmatesItem.offLineTitle");
         _offLineTitleClass.text = LanguageMgr.GetTranslation("itemview.listOffLine");
         addToContent(_offLineTitleClass);
         _emailTitleClass = ComponentFactory.Instance.creatComponentByStylename("academyCommon.MyAcademyClassmatesItem.emailTitle");
         _emailTitleClass.text = LanguageMgr.GetTranslation("itemview.listLink");
         addToContent(_emailTitleClass);
         _disposeTitleClass = ComponentFactory.Instance.creatComponentByStylename("academyCommon.MyAcademyClassmatesItem.addFriendTitle");
         _disposeTitleClass.text = LanguageMgr.GetTranslation("civil.leftview.addName");
         addToContent(_disposeTitleClass);
         _titleline1 = ComponentFactory.Instance.creatComponentByStylename("asset.academyCommon.MyAcademyMasterItem.formIineBig1");
         addToContent(_titleline1);
         _titleline2 = ComponentFactory.Instance.creatComponentByStylename("asset.academyCommon.MyAcademyMasterItem.formIineBig2");
         addToContent(_titleline2);
         _titleline3 = ComponentFactory.Instance.creatComponentByStylename("asset.academyCommon.MyAcademyMasterItem.formIineBig3");
         addToContent(_titleline3);
         _titleline4 = ComponentFactory.Instance.creatComponentByStylename("asset.academyCommon.MyAcademyMasterItem.formIineBig4");
         addToContent(_titleline4);
         _masterItem = new MyAcademyMasterItem();
         PositionUtils.setPos(_masterItem,"academyCommon.myAcademy.MyAcademyApprenticeFrame.masterItem");
         addToContent(_masterItem);
         _classmateItem = new MyAcademyClassmateItem();
         PositionUtils.setPos(_classmateItem,"academyCommon.myAcademy.MyAcademyApprenticeFrame.classmateItem");
         addToContent(_classmateItem);
         _classmateItemII = new MyAcademyClassmateItem();
         PositionUtils.setPos(_classmateItemII,"academyCommon.myAcademy.MyAcademyApprenticeFrame.classmateItemII");
         addToContent(_classmateItemII);
         _ApprenticeInfos = new Vector.<PlayerInfo>();
         updateItem();
      }
      
      override protected function initEvent() : void
      {
         addEventListener("response",__onResponse);
         _masterItem.addEventListener("click",__itemClick);
         _titleBtn.addEventListener("click",__titleBtnClick);
         _classmateItem.addEventListener("click",__itemClick);
         _classmateItemII.addEventListener("click",__itemClick);
         AcademyManager.Instance.myAcademyPlayers.addEventListener("remove",__removeItem);
         AcademyManager.Instance.myAcademyPlayers.addEventListener("clear",__clearItem);
      }
      
      override protected function updateItem() : void
      {
         sliceInfo();
         switch(int(_myApprentice.length))
         {
            case 0:
               _masterItem.visible = false;
               _classmateItem.visible = false;
               _classmateItemII.visible = false;
               break;
            case 1:
               _masterItem.info = _masterInfo;
               _classmateItem.visible = false;
               _classmateItemII.visible = false;
               break;
            case 2:
               _masterItem.info = _masterInfo;
               _classmateItem.info = _ApprenticeInfos[0];
               _classmateItemII.visible = false;
               break;
            case 3:
               _masterItem.info = _masterInfo;
               _classmateItem.info = _ApprenticeInfos[0];
               _classmateItemII.info = _ApprenticeInfos[1];
         }
      }
      
      private function sliceInfo() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _myApprentice;
         for each(var i in _myApprentice)
         {
            if(i.apprenticeshipState == 1)
            {
               _ApprenticeInfos.push(i);
            }
            else
            {
               _masterInfo = i;
            }
         }
      }
      
      override protected function clearItem() : void
      {
         if(_masterItem)
         {
            _masterItem.removeEventListener("click",__itemClick);
            _masterItem.dispose();
            _masterItem = null;
         }
         if(_classmateItem)
         {
            _classmateItem.removeEventListener("click",__itemClick);
            _classmateItem.dispose();
            _classmateItem = null;
         }
         if(_classmateItemII)
         {
            _classmateItemII.removeEventListener("click",__itemClick);
            _classmateItemII.dispose();
            _classmateItemII = null;
         }
      }
   }
}

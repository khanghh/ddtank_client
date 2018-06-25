package ddt.view.academyCommon.myAcademy
{
   import academy.AcademyManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.AcademyFrameManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddt.view.academyCommon.myAcademy.myAcademyItem.MyAcademyApprenticeItem;
   import ddt.view.academyCommon.myAcademy.myAcademyItem.MyAcademyMasterItem;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import road7th.data.DictionaryData;
   import road7th.data.DictionaryEvent;
   
   public class MyAcademyMasterFrame extends BaseAlerFrame implements Disposeable
   {
      
      public static const ITEM_NUM:int = 3;
      
      public static const BOTTOM_GAP:int = 27;
       
      
      protected var _myAcademyTitle:Bitmap;
      
      protected var _myAcademyIcon:Bitmap;
      
      protected var _ItemButtomBg1:ScaleBitmapImage;
      
      protected var _ItemButtomBg2:ScaleBitmapImage;
      
      protected var _ItemButtomBg3:ScaleBitmapImage;
      
      protected var _itemBG:MovieImage;
      
      protected var _titleline1:ScaleBitmapImage;
      
      protected var _titleline2:ScaleBitmapImage;
      
      protected var _titleline3:ScaleBitmapImage;
      
      protected var _titleline4:ScaleBitmapImage;
      
      protected var _titleline5:ScaleBitmapImage;
      
      protected var _titleline6:ScaleBitmapImage;
      
      protected var _nameTitle:FilterFrameText;
      
      protected var _levelTitle:FilterFrameText;
      
      protected var _stateTitle:FilterFrameText;
      
      protected var _sexTitle:FilterFrameText;
      
      protected var _emailTitle:FilterFrameText;
      
      protected var _appreCount:FilterFrameText;
      
      protected var _academyCalled:FilterFrameText;
      
      protected var _offLineTitle:FilterFrameText;
      
      protected var _disposeTitle:FilterFrameText;
      
      protected var _nameTitleClass:FilterFrameText;
      
      protected var _levelTitleClass:FilterFrameText;
      
      protected var _emailTitleClass:FilterFrameText;
      
      protected var _offLineTitleClass:FilterFrameText;
      
      protected var _disposeTitleClass:FilterFrameText;
      
      protected var _titleBtn:TextButton;
      
      protected var _myApprentice:DictionaryData;
      
      protected var _items:Vector.<MyAcademyApprenticeItem>;
      
      protected var _alertInfo:AlertInfo;
      
      protected var _currentItem:MyAcademyMasterItem;
      
      protected var _gradueteNumText:GradientText;
      
      protected var _masterHonorText:GradientText;
      
      public function MyAcademyMasterFrame()
      {
         super();
         initContent();
         initEvent();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,1);
      }
      
      protected function initContent() : void
      {
         _alertInfo = new AlertInfo();
         _alertInfo.title = LanguageMgr.GetTranslation("im.IMView.myAcademyBtnTips");
         _alertInfo.bottomGap = 27;
         _alertInfo.customPos = ComponentFactory.Instance.creatCustomObject("academyCommon.myAcademy.gotoMainlPos2");
         info = _alertInfo;
         _ItemButtomBg1 = ComponentFactory.Instance.creatComponentByStylename("asset.academyCommon.itemButtomBg1");
         addToContent(_ItemButtomBg1);
         _myAcademyTitle = ComponentFactory.Instance.creatBitmap("asset.academyCommon.myAcademy.myAcademyTitle");
         addToContent(_myAcademyTitle);
         _titleBtn = ComponentFactory.Instance.creatComponentByStylename("academyCommon.myAcademy.MyAcademyMasterFrame.titleBtn");
         _titleBtn.text = LanguageMgr.GetTranslation("ddt.manager.showAcademyPreviewFrame.masterFree");
         addToContent(_titleBtn);
         _myApprentice = AcademyManager.Instance.myAcademyPlayers;
         initItem();
      }
      
      protected function initItemContent() : void
      {
         _titleline1 = ComponentFactory.Instance.creatComponentByStylename("asset.academyCommon.formIineBig1");
         addToContent(_titleline1);
         _titleline2 = ComponentFactory.Instance.creatComponentByStylename("asset.academyCommon.formIineBig2");
         addToContent(_titleline2);
         _titleline3 = ComponentFactory.Instance.creatComponentByStylename("asset.academyCommon.formIineBig3");
         addToContent(_titleline3);
         _titleline4 = ComponentFactory.Instance.creatComponentByStylename("asset.academyCommon.formIineBig4");
         addToContent(_titleline4);
         _levelTitle = ComponentFactory.Instance.creatComponentByStylename("academyCommon.item.levelTitle");
         _levelTitle.text = LanguageMgr.GetTranslation("itemview.listlevel");
         addToContent(_levelTitle);
         _offLineTitle = ComponentFactory.Instance.creatComponentByStylename("academyCommon.item.offLineTitle");
         _offLineTitle.text = LanguageMgr.GetTranslation("itemview.listOffLine");
         addToContent(_offLineTitle);
         _emailTitle = ComponentFactory.Instance.creatComponentByStylename("academyCommon.item.emailTitle");
         _emailTitle.text = LanguageMgr.GetTranslation("itemview.listLink");
         addToContent(_emailTitle);
         _disposeTitle = ComponentFactory.Instance.creatComponentByStylename("academyCommon.item.disposeTitle");
         _disposeTitle.text = LanguageMgr.GetTranslation("ddt.view.academyCommon.itemtitle.disposeItem");
         addToContent(_disposeTitle);
      }
      
      protected function initItem() : void
      {
         _myAcademyIcon = ComponentFactory.Instance.creatBitmap("asset.academyCommon.myAcademy.MyAcademyApprenticeIcon");
         addToContent(_myAcademyIcon);
         _ItemButtomBg2 = ComponentFactory.Instance.creatComponentByStylename("asset.academyCommon.itemButtomBg2");
         addToContent(_ItemButtomBg2);
         _ItemButtomBg3 = ComponentFactory.Instance.creatComponentByStylename("asset.academyCommon.itemButtomBg3");
         addToContent(_ItemButtomBg3);
         _gradueteNumText = ComponentFactory.Instance.creatComponentByStylename("view.common.MyAcademyMasterFrame.gradueteNumText");
         _gradueteNumText.text = String(PlayerManager.Instance.Self.graduatesCount);
         addToContent(_gradueteNumText);
         _masterHonorText = ComponentFactory.Instance.creatComponentByStylename("view.common.MyAcademyMasterFrame.masterHonorText");
         _masterHonorText.text = PlayerManager.Instance.Self.honourOfMaster;
         _appreCount = ComponentFactory.Instance.creatComponentByStylename("academyCommon.apprenCount");
         _appreCount.text = LanguageMgr.GetTranslation("ddt.view.academyCommon.apprenCount");
         addToContent(_appreCount);
         _academyCalled = ComponentFactory.Instance.creatComponentByStylename("academyCommon.academyCalled");
         _academyCalled.text = LanguageMgr.GetTranslation("ddt.view.academyCommon.academyRequest.AcademyRegisterFrame.academyHonorLabel");
         _itemBG = ComponentFactory.Instance.creatComponentByStylename("asset.academyCommon.myAcademy.myAcademyApprenticeBG");
         addToContent(_itemBG);
         _nameTitle = ComponentFactory.Instance.creatComponentByStylename("academyCommon.item.nameTitle");
         _nameTitle.text = LanguageMgr.GetTranslation("ddt.view.academyCommon.academyIcon.ApprenticeIcon");
         addToContent(_nameTitle);
         initItemContent();
         _items = new Vector.<MyAcademyApprenticeItem>();
         var apprentice:MyAcademyApprenticeItem = new MyAcademyApprenticeItem();
         PositionUtils.setPos(apprentice,"academyCommon.myAcademy.MyAcademyMasterFrame.Apprentice");
         addToContent(apprentice);
         _items.push(apprentice);
         var apprenticeII:MyAcademyApprenticeItem = new MyAcademyApprenticeItem();
         PositionUtils.setPos(apprenticeII,"academyCommon.myAcademy.MyAcademyMasterFrame.ApprenticeII");
         addToContent(apprenticeII);
         _items.push(apprenticeII);
         var apprenticeIII:MyAcademyApprenticeItem = new MyAcademyApprenticeItem();
         PositionUtils.setPos(apprenticeIII,"academyCommon.myAcademy.MyAcademyMasterFrame.ApprenticeIII");
         addToContent(apprenticeIII);
         _items.push(apprenticeIII);
         updateItem();
      }
      
      protected function initEvent() : void
      {
         var i:int = 0;
         addEventListener("response",__onResponse);
         _titleBtn.addEventListener("click",__titleBtnClick);
         for(i = 0; i < _items.length; )
         {
            _items[i].addEventListener("click",__itemClick);
            i++;
         }
         AcademyManager.Instance.myAcademyPlayers.addEventListener("remove",__removeItem);
         AcademyManager.Instance.myAcademyPlayers.addEventListener("clear",__clearItem);
      }
      
      protected function __titleBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         AcademyFrameManager.Instance.showAcademyPreviewFrame();
      }
      
      protected function __clearItem(event:DictionaryEvent) : void
      {
         updateItem();
      }
      
      protected function __removeItem(event:DictionaryEvent) : void
      {
         updateItem();
      }
      
      protected function updateItem() : void
      {
         var i:int = 0;
         var j:int = 0;
         for(i = 0; i < _myApprentice.list.length; )
         {
            _items[i].info = _myApprentice.list[i];
            i++;
         }
         for(j = _myApprentice.list.length; j < 3; )
         {
            _items[j].visible = false;
            j++;
         }
      }
      
      protected function __onResponse(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(event.responseCode))
         {
            default:
            default:
            case 2:
            case 3:
               AcademyManager.Instance.gotoAcademyState();
            default:
               AcademyManager.Instance.gotoAcademyState();
         }
      }
      
      protected function clearItem() : void
      {
         var i:int = 0;
         for(i = 0; i < _items.length; )
         {
            if(_items[i])
            {
               _items[i].removeEventListener("click",__itemClick);
               _items[i].dispose();
               _items[i] = null;
            }
            i++;
         }
      }
      
      protected function __itemClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(!_currentItem)
         {
            _currentItem = event.currentTarget as MyAcademyMasterItem;
         }
         if(_currentItem != event.currentTarget as MyAcademyMasterItem)
         {
            _currentItem.isSelect = false;
         }
         _currentItem = event.currentTarget as MyAcademyMasterItem;
         _currentItem.isSelect = true;
      }
      
      override public function dispose() : void
      {
         clearItem();
         removeEventListener("response",__onResponse);
         AcademyManager.Instance.myAcademyPlayers.removeEventListener("remove",__removeItem);
         AcademyManager.Instance.myAcademyPlayers.removeEventListener("clear",__clearItem);
         if(_ItemButtomBg1)
         {
            ObjectUtils.disposeObject(_ItemButtomBg1);
            _ItemButtomBg1 = null;
         }
         if(_ItemButtomBg2)
         {
            ObjectUtils.disposeObject(_ItemButtomBg2);
            _ItemButtomBg2 = null;
         }
         if(_ItemButtomBg3)
         {
            ObjectUtils.disposeObject(_ItemButtomBg3);
            _ItemButtomBg3 = null;
         }
         if(_appreCount)
         {
            ObjectUtils.disposeObject(_appreCount);
            _appreCount = null;
         }
         if(_academyCalled)
         {
            ObjectUtils.disposeObject(_academyCalled);
            _academyCalled = null;
         }
         if(_itemBG)
         {
            ObjectUtils.disposeObject(_itemBG);
            _itemBG = null;
         }
         if(_myAcademyIcon)
         {
            ObjectUtils.disposeObject(_myAcademyIcon);
            _myAcademyIcon = null;
         }
         if(_titleline1)
         {
            _titleline1.dispose();
            _titleline1 = null;
         }
         if(_titleline2)
         {
            _titleline2.dispose();
            _titleline2 = null;
         }
         if(_titleline3)
         {
            _titleline3.dispose();
            _titleline3 = null;
         }
         if(_titleline4)
         {
            _titleline4.dispose();
            _titleline4 = null;
         }
         if(_titleline5)
         {
            _titleline5.dispose();
            _titleline5 = null;
         }
         if(_titleline6)
         {
            _titleline6.dispose();
            _titleline6 = null;
         }
         if(_myAcademyTitle)
         {
            ObjectUtils.disposeObject(_myAcademyTitle);
            _myAcademyTitle = null;
         }
         if(_nameTitle)
         {
            ObjectUtils.disposeObject(_nameTitle);
            _nameTitle = null;
         }
         if(_levelTitle)
         {
            ObjectUtils.disposeObject(_levelTitle);
            _levelTitle = null;
         }
         if(_sexTitle)
         {
            ObjectUtils.disposeObject(_sexTitle);
            _sexTitle = null;
         }
         if(_stateTitle)
         {
            ObjectUtils.disposeObject(_stateTitle);
            _stateTitle = null;
         }
         if(_offLineTitle)
         {
            ObjectUtils.disposeObject(_offLineTitle);
            _offLineTitle = null;
         }
         if(_emailTitle)
         {
            ObjectUtils.disposeObject(_emailTitle);
            _emailTitle = null;
         }
         if(_disposeTitle)
         {
            ObjectUtils.disposeObject(_disposeTitle);
            _disposeTitle = null;
         }
         if(_nameTitleClass)
         {
            ObjectUtils.disposeObject(_nameTitleClass);
            _nameTitleClass = null;
         }
         if(_levelTitleClass)
         {
            ObjectUtils.disposeObject(_levelTitleClass);
            _levelTitleClass = null;
         }
         if(_emailTitleClass)
         {
            ObjectUtils.disposeObject(_emailTitleClass);
            _emailTitleClass = null;
         }
         if(_offLineTitleClass)
         {
            ObjectUtils.disposeObject(_offLineTitleClass);
            _offLineTitleClass = null;
         }
         if(_disposeTitleClass)
         {
            ObjectUtils.disposeObject(_disposeTitleClass);
            _disposeTitleClass = null;
         }
         if(_gradueteNumText)
         {
            _gradueteNumText.dispose();
            _gradueteNumText = null;
         }
         if(_masterHonorText)
         {
            _masterHonorText.dispose();
            _masterHonorText = null;
         }
         if(_titleBtn)
         {
            _titleBtn.removeEventListener("click",__titleBtnClick);
            ObjectUtils.disposeObject(_titleBtn);
            _titleBtn = null;
         }
         if(_currentItem)
         {
            _currentItem.dispose();
            _currentItem = null;
         }
         super.dispose();
      }
   }
}

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
      
      public function MyAcademyMasterFrame(){super();}
      
      public function show() : void{}
      
      protected function initContent() : void{}
      
      protected function initItemContent() : void{}
      
      protected function initItem() : void{}
      
      protected function initEvent() : void{}
      
      protected function __titleBtnClick(param1:MouseEvent) : void{}
      
      protected function __clearItem(param1:DictionaryEvent) : void{}
      
      protected function __removeItem(param1:DictionaryEvent) : void{}
      
      protected function updateItem() : void{}
      
      protected function __onResponse(param1:FrameEvent) : void{}
      
      protected function clearItem() : void{}
      
      protected function __itemClick(param1:MouseEvent) : void{}
      
      override public function dispose() : void{}
   }
}

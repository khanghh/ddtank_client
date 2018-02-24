package anotherDimension.view
{
   import anotherDimension.controller.AnotherDimensionManager;
   import anotherDimension.model.AnotherDimensionResourceInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.TimeManager;
   import flash.display.Sprite;
   
   public class AnotherDimensionOtherTip extends Sprite implements Disposeable
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _line:ScaleBitmapImage;
      
      private var _titleTxt:FilterFrameText;
      
      private var _chanchuTitleTxt:FilterFrameText;
      
      private var _chanliangTitleTxt:FilterFrameText;
      
      private var _canLueduoTitleTxt:FilterFrameText;
      
      private var _chanchuText:FilterFrameText;
      
      private var _chanliangText:FilterFrameText;
      
      private var _canLueduoText:FilterFrameText;
      
      private var _line2:ScaleBitmapImage;
      
      private var _haveItemText:FilterFrameText;
      
      private var _info:AnotherDimensionResourceInfo;
      
      private var hourTime:Number = 3600000.0;
      
      private var minuteTime:Number = 60000.0;
      
      public function AnotherDimensionOtherTip(param1:AnotherDimensionResourceInfo){super();}
      
      public function setSelfTipStyle(param1:AnotherDimensionResourceInfo) : void{}
      
      private function getItemCountByTime(param1:AnotherDimensionResourceInfo) : int{return 0;}
      
      private function getItemCountByTime2(param1:AnotherDimensionResourceInfo) : int{return 0;}
      
      public function refreshView(param1:AnotherDimensionResourceInfo) : void{}
      
      private function getTimeControlExpBylv(param1:int) : Array{return null;}
      
      public function dispose() : void{}
   }
}

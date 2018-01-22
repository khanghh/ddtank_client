package totem.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.text.TextFormat;
   import totem.TotemManager;
   import totem.data.TotemDataVo;
   
   public class TotemPointTipView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _propertyNameTxt:FilterFrameText;
      
      private var _propertyValueTxt:FilterFrameText;
      
      private var _possibleNameTxt:FilterFrameText;
      
      private var _possibleValueTxt:FilterFrameText;
      
      private var _propertyValueList:Array;
      
      private var _possibleValeList:Array;
      
      private var _propertyValueTextFormatList:Vector.<TextFormat>;
      
      private var _propertyValueGlowFilterList:Vector.<GlowFilter>;
      
      private var _possibleValueTxtColorList:Array;
      
      private var _honorExpSprite:Sprite;
      
      private var _honorTxt:FilterFrameText;
      
      private var _expTxt:FilterFrameText;
      
      private var _lvAddPropertyTxtSprite:Sprite;
      
      private var _lvAddPropertyTxtList:Vector.<FilterFrameText>;
      
      private var _bg2:Bitmap;
      
      private var _statusNameTxt:FilterFrameText;
      
      private var _statusValueTxt:FilterFrameText;
      
      private var _currentPropertyTxt:FilterFrameText;
      
      private var _statusValueList:Array;
      
      public function TotemPointTipView(){super();}
      
      private function initData() : void{}
      
      private function initView() : void{}
      
      public function show(param1:TotemDataVo, param2:Boolean, param3:Boolean) : void{}
      
      private function showStatus1() : void{}
      
      private function showStatus2() : void{}
      
      public function getValueByIndex(param1:int, param2:TotemDataVo) : int{return 0;}
      
      public function dispose() : void{}
   }
}

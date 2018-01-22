package totem.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import totem.TotemManager;
   import totem.data.TotemAddInfo;
   
   public class TotemLeftWindowChapterTipView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _titleTxt:FilterFrameText;
      
      private var _nameTxt:FilterFrameText;
      
      private var _valueTxtList:Vector.<FilterFrameText>;
      
      private var _titleTxtList:Array;
      
      private var _numTxtList:Array;
      
      private var _propertyTxtList:Array;
      
      public function TotemLeftWindowChapterTipView(){super();}
      
      private function initView() : void{}
      
      public function show(param1:int) : void{}
      
      private function getAddValue(param1:int, param2:TotemAddInfo) : int{return 0;}
      
      public function dispose() : void{}
   }
}

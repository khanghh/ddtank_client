package ddt.view.common
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.geom.Matrix;
   import flash.text.TextFormat;
   
   public class GradientText extends Sprite implements Disposeable
   {
      
      public static var RandomColors:Array = [65508,16711782,16763904,14978897,9895680,14483225,10400767,16742025,50943,13390591];
      
      public static var randomFont:Array = ["AdLib BT","Arial Black","VAG Rounded Std Thin","Britannic Bold","Berlin Sans FB Demi","Benguiat Bk BT","Kabel Ult BT","Tw Cen MT Condensed Extra Bold","Cooper Std Black","Copperplate Gothic Bold","CastleTUlt","FrnkGothITC Hv BT"];
      
      public static var randomFontSize:Array = [0,2];
       
      
      private var _field:FilterFrameText;
      
      private var _textFormat:TextFormat;
      
      private var graidenBox:Sprite;
      
      private var currentMatix:Matrix;
      
      private var currentColors:Array;
      
      private var randomColor:Array;
      
      public function GradientText(field:FilterFrameText, randomColor:Array = null)
      {
         super();
         _field = field;
         _textFormat = ComponentFactory.Instance.model.getSet("game.vaneGradientTextTF");
         this.randomColor = !!randomColor?randomColor:RandomColors;
         addChild(_field);
         graidenBox = new Sprite();
         addChild(graidenBox);
      }
      
      public function setText(s:String, randerColor:Boolean = true, randerFont:Boolean = false) : void
      {
         _field.text = s;
         render(randerColor,randerFont);
      }
      
      public function get text() : String
      {
         return _field.text;
      }
      
      public function set autoSize(align:String) : void
      {
         _field.autoSize = align;
      }
      
      private function render(isChangeColor:Boolean, isChangeFont:Boolean) : void
      {
         if(isChangeFont)
         {
            setTextStyle(getRandomFont());
         }
         if(isChangeColor)
         {
            drawBox();
         }
         else
         {
            drawBoxWithCurrent();
         }
         graidenBox.x = _field.x;
         graidenBox.y = _field.y;
         _field.cacheAsBitmap = true;
         graidenBox.cacheAsBitmap = true;
         graidenBox.mask = _field;
      }
      
      private function drawBox() : void
      {
         var alphas:Array = [1,1];
         var ratios:Array = [0,255];
         currentMatix = new Matrix();
         currentMatix.createGradientBox(_field.width / 2,_field.height,3.14159265358979 / 4,0,0);
         currentColors = getRandomColors();
         graidenBox.graphics.clear();
         graidenBox.graphics.beginGradientFill("linear",currentColors,alphas,ratios,currentMatix);
         graidenBox.graphics.drawRect(0,0,_field.width / 2,_field.height);
         graidenBox.graphics.endFill();
         currentMatix = new Matrix();
         currentMatix.createGradientBox(_field.width / 2,_field.height,3.14159265358979 / 4,0,0);
         currentColors = getRandomColors();
         graidenBox.graphics.beginGradientFill("linear",currentColors,alphas,ratios,currentMatix);
         graidenBox.graphics.drawRect(_field.width / 2,0,_field.width / 2,_field.height);
         graidenBox.graphics.endFill();
      }
      
      private function drawBoxWithCurrent() : void
      {
         var alphas:Array = [1,1];
         var ratios:Array = [0,255];
         graidenBox.graphics.clear();
         graidenBox.graphics.beginGradientFill("linear",currentColors,alphas,ratios,currentMatix);
         graidenBox.graphics.drawRect(0,0,_field.width,_field.height);
         graidenBox.graphics.endFill();
      }
      
      private function getRandomColors() : Array
      {
         var cs:Array = [];
         cs = randomColor[int(Math.random() * 10000 % 16)];
         var c1:int = cs[0];
         var c2:int = cs[1];
         return [c1,c2];
      }
      
      private function getRandomFont() : String
      {
         return randomFont[int(Math.random() * 10000 % randomFont.length)];
      }
      
      private function getRandomFontSize() : int
      {
         return randomFontSize[int(Math.random() * 10000 % randomFontSize.length)];
      }
      
      private function setTextStyle(ftName:String) : void
      {
         _textFormat.font = ftName;
         var addFontSize:int = getRandomFontSize();
         var _loc3_:* = ftName;
         if("AdLib BT" !== _loc3_)
         {
            if("Arial Black" !== _loc3_)
            {
               if("VAG Rounded Std Thin" !== _loc3_)
               {
                  if("Britannic Bold" !== _loc3_)
                  {
                     if("Berlin Sans FB Demi" !== _loc3_)
                     {
                        if("Benguiat Bk BT" !== _loc3_)
                        {
                           if("Kabel Ult BT" !== _loc3_)
                           {
                              if("Tw Cen MT Condensed Extra Bold" !== _loc3_)
                              {
                                 if("Cooper Std Black" !== _loc3_)
                                 {
                                    if("Copperplate Gothic Bold" !== _loc3_)
                                    {
                                       if("CastleTUlt" !== _loc3_)
                                       {
                                          if("FrnkGothITC Hv BT" === _loc3_)
                                          {
                                             _textFormat.size = 18 + addFontSize;
                                             _field.x = 6.2;
                                             _field.y = 1.9;
                                          }
                                       }
                                       else
                                       {
                                          _textFormat.size = 19 + addFontSize;
                                          _field.x = 5.9;
                                          _field.y = 2.1;
                                       }
                                    }
                                    else
                                    {
                                       _textFormat.size = 19 + addFontSize;
                                       _field.x = 3.8;
                                       _field.y = 2.9;
                                    }
                                 }
                                 else
                                 {
                                    _textFormat.size = 18 + addFontSize;
                                    _field.x = 6.1;
                                    _field.y = 0.4;
                                 }
                              }
                              else
                              {
                                 _textFormat.size = 20 + addFontSize;
                                 _field.x = 7.7;
                                 _field.y = 1.7;
                              }
                           }
                           else
                           {
                              _textFormat.size = 18 + addFontSize;
                              _field.x = 7.3;
                              _field.y = 2.3;
                           }
                        }
                        else
                        {
                           _textFormat.size = 19 + addFontSize;
                           _field.x = 4.7;
                           _field.y = 1.6;
                        }
                     }
                     else
                     {
                        _textFormat.size = 21 + addFontSize;
                        _field.x = 5.4;
                        _field.y = 0.3;
                     }
                  }
                  else
                  {
                     _textFormat.size = 19 + addFontSize;
                     _field.x = 5.9;
                     _field.y = 2.7;
                  }
               }
               else
               {
                  _textFormat.size = 18 + addFontSize;
                  _field.x = 7.4;
                  _field.y = 3;
               }
            }
            else
            {
               _textFormat.size = 18 + addFontSize;
               _field.x = 5.2;
               _field.y = 0.4;
            }
         }
         else
         {
            _textFormat.size = 16 + addFontSize;
            _field.x = 5.5;
            _field.y = 3.5;
         }
         _field.setTextFormat(_textFormat);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_field);
         _field = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

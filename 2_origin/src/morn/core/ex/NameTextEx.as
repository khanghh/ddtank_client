package morn.core.ex
{
   import flash.filters.GlowFilter;
   import morn.core.components.Label;
   import morn.core.utils.ObjectUtils;
   
   public class NameTextEx extends Label
   {
      
      private static const NORMAL_TEXT:int = 1;
      
      private static const VIP_TEXT:int = 2;
      
      private static const OLDPLAYER_TEXT:int = 3;
       
      
      private var _textType:int;
      
      public function NameTextEx(text:String = "", skin:String = null)
      {
         super(text,skin);
         size = 20;
      }
      
      public function get textType() : int
      {
         return _textType;
      }
      
      public function set textType(value:int) : void
      {
         _textType = value;
         if(_gradientColor)
         {
            ObjectUtils.clearFilter(_gradientSp,GlowFilter);
            _gradientColor = null;
            _gradientStroke = null;
            if(_gradientSp)
            {
               if(_gradientSp.parent)
               {
                  _gradientSp.parent.removeChild(_gradientSp);
               }
               _gradientSp.mask = null;
               _gradientSp = null;
            }
         }
         if(color)
         {
            ObjectUtils.clearFilter(_textField,GlowFilter);
            _format.color = null;
            _stroke = null;
         }
         switch(int(textType) - 1)
         {
            case 0:
               color = 16777215;
               stroke = "0x000000,1,2,2,10";
               break;
            case 1:
               ObjectUtils.clearFilter(_textField,GlowFilter);
               gradientColor = "0xf3ff32,0xff9600";
               gradientStroke = "0x441300,1,2,2,10";
               break;
            case 2:
               color = 16711680;
               stroke = "0x000000,1,2,2,10";
         }
      }
   }
}

package totem.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import flash.display.Sprite;
   import totem.TotemManager;
   import totem.data.TotemAddInfo;
   
   public class TotemRightViewTxtTxtCell extends Sprite implements Disposeable
   {
       
      
      private var _leftTxt:FilterFrameText;
      
      private var _rightTxt:FilterFrameText;
      
      private var _txtArray:Array;
      
      private var _type:int;
      
      public function TotemRightViewTxtTxtCell(){super();}
      
      public function show(param1:int) : void{}
      
      public function refresh() : void{}
      
      public function dispose() : void{}
   }
}

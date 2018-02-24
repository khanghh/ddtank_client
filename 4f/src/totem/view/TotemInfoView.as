package totem.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import totem.TotemManager;
   
   public class TotemInfoView extends Sprite implements Disposeable
   {
       
      
      private var _windowView:TotemLeftWindowView;
      
      private var _levelBg:Bitmap;
      
      private var _level:FilterFrameText;
      
      private var _txtBg:Bitmap;
      
      private var _propertyList:Vector.<TotemInfoViewTxtCell>;
      
      private var _info:PlayerInfo;
      
      public function TotemInfoView(param1:PlayerInfo){super();}
      
      private function initView() : void{}
      
      public function dispose() : void{}
   }
}

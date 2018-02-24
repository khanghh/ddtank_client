package consortion.view.selfConsortia
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedTextButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.BadgeInfoManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class BadgeShopPanel extends Sprite implements Disposeable
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _levelBtn1:SelectedTextButton;
      
      private var _levelBtn2:SelectedTextButton;
      
      private var _levelBtn3:SelectedTextButton;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _list:BadgeShopList;
      
      public function BadgeShopPanel(){super();}
      
      private function initView() : void{}
      
      private function onSelectChange(param1:Event) : void{}
      
      public function dispose() : void{}
   }
}

package ddQiYuan.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import flash.display.Sprite;
   
   public class TowerItem extends Sprite implements Disposeable
   {
       
      
      private var _bgImage:ScaleFrameImage;
      
      private var _infoTf:FilterFrameText;
      
      private var _data:Object;
      
      public function TowerItem(){super();}
      
      public function setData(param1:Object) : void{}
      
      public function dispose() : void{}
   }
}

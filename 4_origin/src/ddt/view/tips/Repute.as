package ddt.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class Repute extends Sprite implements Disposeable
   {
      
      public static const LEFT:String = "left";
      
      public static const RIGHT:String = "right";
       
      
      protected var _repute:int;
      
      protected var _level:int;
      
      protected var _reputeTxt:FilterFrameText;
      
      protected var _reputeBg:Bitmap;
      
      protected var _align:String = "right";
      
      protected var dx:int;
      
      public function Repute(param1:int = 0, param2:int = 0)
      {
         super();
         _repute = param1;
         _level = param2;
         _reputeBg = ComponentFactory.Instance.creat("asset.core.leveltip.ReputeBg");
         _reputeTxt = ComponentFactory.Instance.creat("core.ReputeTxt");
         dx = _reputeTxt.x;
         addChild(_reputeBg);
         addChild(_reputeTxt);
         setRepute(_repute);
      }
      
      public function set level(param1:int) : void
      {
         this._level = param1;
      }
      
      public function setRepute(param1:int) : void
      {
         _repute = param1;
         _reputeTxt.text = _level <= 3 || param1 > 9999999 || param1 == 0?LanguageMgr.GetTranslation("tank.room.RoomIIPlayerItem.new"):String(param1);
         _reputeTxt.width = _reputeTxt.textWidth + 3;
         if(_align == "left")
         {
            _reputeBg.x = 0;
            _reputeTxt.x = _reputeBg.x + dx;
         }
         else
         {
            _reputeTxt.x = -_reputeTxt.textWidth;
            _reputeBg.x = _reputeTxt.x - dx;
         }
      }
      
      public function set align(param1:String) : void
      {
         _align = param1;
         if(param1 == "left")
         {
            _reputeBg.x = 0;
            _reputeTxt.x = _reputeBg.x + dx;
         }
         else
         {
            _reputeTxt.x = -_reputeTxt.textWidth;
            _reputeBg.x = _reputeTxt.x - dx;
         }
      }
      
      public function dispose() : void
      {
         if(_reputeTxt)
         {
            ObjectUtils.disposeObject(_reputeTxt);
         }
         _reputeTxt = null;
         if(_reputeBg)
         {
            ObjectUtils.disposeObject(_reputeBg);
         }
         _reputeBg = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

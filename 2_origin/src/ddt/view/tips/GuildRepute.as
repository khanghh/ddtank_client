package ddt.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class GuildRepute extends Sprite implements Disposeable
   {
       
      
      private var _reputeTxt:FilterFrameText;
      
      private var _reputeBg:Bitmap;
      
      public function GuildRepute()
      {
         super();
         _reputeBg = ComponentFactory.Instance.creat("asset.core.leveltip.ReputeBg");
         var p:Point = ComponentFactory.Instance.creatCustomObject("asset.core.guildReputePos");
         _reputeBg.x = p.x;
         _reputeTxt = ComponentFactory.Instance.creat("core.guildReputeTxt");
         addChild(_reputeBg);
         addChild(_reputeTxt);
      }
      
      public function setRepute(re:int) : void
      {
         _reputeTxt.text = String(re);
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

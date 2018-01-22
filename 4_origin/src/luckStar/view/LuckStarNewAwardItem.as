package luckStar.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ItemManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class LuckStarNewAwardItem extends Sprite implements Disposeable
   {
       
      
      private var nameText:FilterFrameText;
      
      private var awardText:FilterFrameText;
      
      private var _bg:Bitmap;
      
      public function LuckStarNewAwardItem()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         nameText = ComponentFactory.Instance.creat("luckyStar.rankItem.newRankNmaeText");
         awardText = ComponentFactory.Instance.creat("luckyStar.rankItem.newRankAwardText");
         _bg = ComponentFactory.Instance.creat("luckyStar.view.line");
         addChild(_bg);
         addChild(nameText);
         addChild(awardText);
      }
      
      public function setText(param1:String, param2:int, param3:int) : void
      {
         var _loc4_:* = null;
         if(ItemManager.Instance.getTemplateById(param2))
         {
            nameText.text = param1;
            _loc4_ = ItemManager.Instance.getTemplateById(param2).Name + " x " + param3.toString();
            if(ItemManager.Instance.getTemplateById(param2).Quality >= 5)
            {
               _loc4_ = _loc4_.replace(_loc4_,"<font color=\'#ff0000\'>" + _loc4_ + "</font>");
            }
            awardText.htmlText = _loc4_;
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(nameText);
         nameText = null;
         ObjectUtils.disposeObject(awardText);
         awardText = null;
      }
   }
}

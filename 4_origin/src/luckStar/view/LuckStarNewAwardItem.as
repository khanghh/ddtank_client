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
      
      public function setText($name:String, $award:int, $count:int) : void
      {
         var goods:* = null;
         if(ItemManager.Instance.getTemplateById($award))
         {
            nameText.text = $name;
            goods = ItemManager.Instance.getTemplateById($award).Name + " x " + $count.toString();
            if(ItemManager.Instance.getTemplateById($award).Quality >= 5)
            {
               goods = goods.replace(goods,"<font color=\'#ff0000\'>" + goods + "</font>");
            }
            awardText.htmlText = goods;
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

package ddtmatch.view
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class DDTMatchFightKingItem extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _itemTitleTxt:FilterFrameText;
      
      private var _hBox:HBox;
      
      public function DDTMatchFightKingItem(score:int, cellList:Array)
      {
         var i:int = 0;
         var awardsBox:* = null;
         var cell:* = null;
         super();
         _bg = ComponentFactory.Instance.creatBitmap("ddtmatch.fightKing.socreBg");
         addChild(_bg);
         _itemTitleTxt = ComponentFactory.Instance.creatComponentByStylename("ddtmatch.fightKing.itemTitleTxt");
         addChild(_itemTitleTxt);
         _itemTitleTxt.text = LanguageMgr.GetTranslation("ddt.DDTMatch.fightKing.itemTitle",score);
         _hBox = ComponentFactory.Instance.creatComponentByStylename("ddtmatch.fightKing.hBox");
         addChild(_hBox);
         for(i = 0; i < cellList.length; )
         {
            awardsBox = ComponentFactory.Instance.creatBitmap("ddtmatch.fightKing.cellBg");
            cell = new BagCell(1,null,true,awardsBox,false);
            cell.setContentSize(47,47);
            cell.info = ItemManager.Instance.getTemplateById(int(cellList[i].split(",")[0]));
            cell.setCount(int(cellList[i].split(",")[1]));
            _hBox.addChild(cell);
            i++;
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_itemTitleTxt);
         _itemTitleTxt = null;
         ObjectUtils.disposeObject(_hBox);
         _hBox = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

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
      
      public function DDTMatchFightKingItem(param1:int, param2:Array)
      {
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc3_:* = null;
         super();
         _bg = ComponentFactory.Instance.creatBitmap("ddtmatch.fightKing.socreBg");
         addChild(_bg);
         _itemTitleTxt = ComponentFactory.Instance.creatComponentByStylename("ddtmatch.fightKing.itemTitleTxt");
         addChild(_itemTitleTxt);
         _itemTitleTxt.text = LanguageMgr.GetTranslation("ddt.DDTMatch.fightKing.itemTitle",param1);
         _hBox = ComponentFactory.Instance.creatComponentByStylename("ddtmatch.fightKing.hBox");
         addChild(_hBox);
         _loc5_ = 0;
         while(_loc5_ < param2.length)
         {
            _loc4_ = ComponentFactory.Instance.creatBitmap("ddtmatch.fightKing.cellBg");
            _loc3_ = new BagCell(1,null,true,_loc4_,false);
            _loc3_.setContentSize(47,47);
            _loc3_.info = ItemManager.Instance.getTemplateById(int(param2[_loc5_].split(",")[0]));
            _loc3_.setCount(int(param2[_loc5_].split(",")[1]));
            _hBox.addChild(_loc3_);
            _loc5_++;
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

package store.view.shortcutBuy
{
   import bagAndInfo.cell.BaseCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.command.ShineObject;
   import ddt.data.EquipType;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.LanguageMgr;
   import flash.display.Sprite;
   
   public class ShortcutBuyCell extends BaseCell
   {
       
      
      private var _selected:Boolean = false;
      
      private var _mcBg:ScaleFrameImage;
      
      private var _lightEffect:Scale9CornerImage;
      
      private var _nameArr:Array;
      
      private var _shiner:ShineObject;
      
      private var _itemInfo:ItemTemplateInfo;
      
      private var _shortcutText:FilterFrameText;
      
      private var _shortcutTextBg:ScaleBitmapImage;
      
      public function ShortcutBuyCell(param1:ItemTemplateInfo)
      {
         _nameArr = [LanguageMgr.GetTranslation("store.view.ShortcutBuyCell.lingju"),LanguageMgr.GetTranslation("store.view.ShortcutBuyCell.jiezi"),LanguageMgr.GetTranslation("store.view.ShortcutBuyCell.shouzhuo"),LanguageMgr.GetTranslation("store.view.ShortcutBuyCell.baozhu"),LanguageMgr.GetTranslation("store.view.ShortcutBuyCell.zhuque"),LanguageMgr.GetTranslation("store.view.ShortcutBuyCell.xuanwu"),LanguageMgr.GetTranslation("store.view.ShortcutBuyCell.qinglong"),LanguageMgr.GetTranslation("store.view.ShortcutBuyCell.baihu")];
         var _loc2_:Sprite = new Sprite();
         _loc2_.addChild(ComponentFactory.Instance.creatBitmap("asset.ddtstore.EquipCellBG"));
         super(_loc2_);
         tipDirctions = "7,0";
         _itemInfo = param1;
         initII();
      }
      
      private function initII() : void
      {
         var _loc1_:* = null;
         var _loc2_:int = 0;
         _mcBg = ComponentFactory.Instance.creatComponentByStylename("ddtstore.ShortcutBuyFrame.ShortcutCellBg");
         _lightEffect = ComponentFactory.Instance.creatComponentByStylename("asset.ddtstore.CellBgSelectEffect");
         _lightEffect.visible = false;
         _mcBg.setFrame(1);
         addChildAt(_mcBg,0);
         _shiner = new ShineObject(ComponentFactory.Instance.creat("asset.ddtstore.cellShine"));
         var _loc3_:* = false;
         _shiner.visible = _loc3_;
         _loc3_ = _loc3_;
         _shiner.mouseEnabled = _loc3_;
         _shiner.mouseChildren = _loc3_;
         addChildAt(_shiner,1);
         _shortcutTextBg = ComponentFactory.Instance.creatComponentByStylename("ddtstore.ShortcutBuyFrame.ShortcutTextBg");
         addChild(_shortcutTextBg);
         _shortcutText = ComponentFactory.Instance.creatComponentByStylename("ddtstore.ShortcutBuyFrame.ShortcutText");
         _shortcutText.mouseEnabled = false;
         if(EquipType.isComposeStone(_itemInfo))
         {
            _shortcutText.text = LanguageMgr.GetTranslation("store.view.ShortcutBuyCell.Stone" + _itemInfo.Property3);
         }
         else if(EquipType.isBeadNeedOpen(_itemInfo))
         {
            _shortcutText.text = _itemInfo.Name;
            _shortcutText.x = 4;
            _shortcutText.y = 69;
            _shortcutTextBg.width = 70;
         }
         else
         {
            _loc1_ = "";
            _loc2_ = 0;
            while(_loc2_ < _nameArr.length)
            {
               if(_itemInfo.Name.indexOf(_nameArr[_loc2_]) > 0)
               {
                  _loc1_ = _nameArr[_loc2_];
                  break;
               }
               _loc2_++;
            }
            _shortcutText.text = _loc1_;
         }
         _shortcutTextBg.x = _shortcutText.x - 9;
         addChild(_shortcutText);
         if(_shortcutText.text == "")
         {
            _loc3_ = -3;
            _mcBg.x = _loc3_;
            _lightEffect.x = _loc3_;
            _loc3_ = -3;
            _mcBg.y = _loc3_;
            _lightEffect.y = _loc3_;
         }
      }
      
      override public function set info(param1:ItemTemplateInfo) : void
      {
         .super.info = param1;
         if(_lightEffect)
         {
            addChild(_lightEffect);
         }
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         if(_selected == param1)
         {
            return;
         }
         _selected = param1;
         _lightEffect.visible = _selected;
      }
      
      public function startShine() : void
      {
         _shiner.visible = true;
         _shiner.shine();
      }
      
      public function stopShine() : void
      {
         _shiner.stopShine();
         _shiner.visible = false;
      }
      
      public function showBg() : void
      {
         _mcBg.visible = true;
      }
      
      public function hideBg() : void
      {
         _mcBg.visible = false;
         _lightEffect.visible = false;
      }
      
      override public function dispose() : void
      {
         if(_shortcutText)
         {
            ObjectUtils.disposeObject(_shortcutText);
         }
         _shortcutText = null;
         if(_shiner)
         {
            ObjectUtils.disposeObject(_shiner);
         }
         _shiner = null;
         if(_mcBg)
         {
            ObjectUtils.disposeObject(_mcBg);
         }
         _mcBg = null;
         if(_lightEffect)
         {
            ObjectUtils.disposeObject(_lightEffect);
         }
         _lightEffect = null;
         _itemInfo = null;
         _nameArr = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

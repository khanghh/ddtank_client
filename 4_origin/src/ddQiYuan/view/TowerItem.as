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
      
      public function TowerItem()
      {
         super();
         _bgImage = ComponentFactory.Instance.creatComponentByStylename("ddQiYuan.tower.itemBg");
         addChild(_bgImage);
         _infoTf = new FilterFrameText();
         _infoTf.autoSize = "none";
         _infoTf.width = 92;
         _infoTf.height = 42;
         _infoTf.x = 5;
         _infoTf.y = 13;
         addChild(_infoTf);
      }
      
      public function setData(param1:Object) : void
      {
         _data = param1;
         if(_data["currCount"] < _data["needCount"])
         {
            _bgImage.setFrame(1);
            _infoTf.textFormatStyle = "ddQiYuan.tower.itemUncompleteTf.format";
            _infoTf.filterString = "ddQiYuan.tower.itemUncompleteTf.filter";
         }
         else
         {
            _bgImage.setFrame(2);
            _infoTf.textFormatStyle = "ddQiYuan.tower.itemCompleteTf.format";
            _infoTf.filterString = "ddQiYuan.tower.itemCompleteTf.filter";
         }
         var _loc2_:String = ItemManager.Instance.getTemplateById(_data["goodId"]).Name;
         if(_loc2_.length > 5)
         {
            _bgImage.tipStyle = "ddt.view.tips.OneLineTip";
            _bgImage.tipDirctions = "4";
            _bgImage.tipGapV = 2;
            _bgImage.tipGapH = -117;
            _bgImage.tipData = _loc2_;
            _loc2_ = _loc2_.slice(0,4) + "...";
         }
         _infoTf.text = LanguageMgr.GetTranslation("ddQiYuan.tower.frame.itemInfoTfMsg",_data["currCount"],_data["needCount"],_loc2_);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _bgImage = null;
         _infoTf = null;
         _data = null;
      }
   }
}

package flowerGiving.views
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flowerGiving.FlowerGivingManager;
   import wonderfulActivity.data.GmActivityInfo;
   
   public class FlowerMainView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _bottomBg:ScaleBitmapImage;
      
      private var _desc:FilterFrameText;
      
      private var _givingBtn:SimpleBitmapButton;
      
      private var _frame:Frame;
      
      public function FlowerMainView()
      {
         super();
         initView();
         addEvents();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creat("flowerGiving.mainPageBG");
         addChild(_bg);
         _bottomBg = ComponentFactory.Instance.creatComponentByStylename("flowerGiving.bottomBG");
         addChild(_bottomBg);
         _desc = ComponentFactory.Instance.creatComponentByStylename("flowerGiving.deepBrownTxt");
         PositionUtils.setPos(_desc,"flowerGiving.descPos");
         _desc.text = LanguageMgr.GetTranslation("flowerGiving.desc");
         addChild(_desc);
         _givingBtn = ComponentFactory.Instance.creatComponentByStylename("flowerGiving.givingBtn");
         addChild(_givingBtn);
         setActDate();
      }
      
      private function addEvents() : void
      {
         _givingBtn.addEventListener("click",__clickHandler);
      }
      
      protected function __clickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _frame = ComponentFactory.Instance.creatCustomObject("flowerGiving.FlowerSendFrame");
         _frame.titleText = LanguageMgr.GetTranslation("flowerGiving.flowerSendFrame.title");
         LayerManager.Instance.addToLayer(_frame,3,true,1);
      }
      
      public function setActDate() : void
      {
         var _loc2_:GmActivityInfo = FlowerGivingManager.instance.xmlData;
         var _loc5_:String = dateTrim(_loc2_.beginTime,true);
         var _loc4_:String = dateTrim(_loc2_.endTime,true);
         var _loc1_:String = dateTrim(_loc2_.beginShowTime);
         var _loc3_:String = dateTrim(_loc2_.endShowTime);
         _desc.text = LanguageMgr.GetTranslation("flowerGiving.desc",_loc5_,_loc4_,_loc1_,_loc3_);
      }
      
      private function dateTrim(param1:String, param2:Boolean = false) : String
      {
         var _loc3_:String = "";
         var _loc4_:Array = param1.split(" ");
         _loc3_ = _loc4_[0].replace(/\//g,"-");
         if(param2)
         {
            _loc3_ = _loc3_ + (" " + _loc4_[1].slice(0,5));
         }
         return _loc3_;
      }
      
      private function removeEvents() : void
      {
         _givingBtn.removeEventListener("click",__clickHandler);
      }
      
      public function dispose() : void
      {
         _frame = null;
         removeEvents();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_bottomBg);
         _bottomBg = null;
         ObjectUtils.disposeObject(_desc);
         _desc = null;
         ObjectUtils.disposeObject(_givingBtn);
         _givingBtn = null;
      }
   }
}

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
      
      protected function __clickHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _frame = ComponentFactory.Instance.creatCustomObject("flowerGiving.FlowerSendFrame");
         _frame.titleText = LanguageMgr.GetTranslation("flowerGiving.flowerSendFrame.title");
         LayerManager.Instance.addToLayer(_frame,3,true,1);
      }
      
      public function setActDate() : void
      {
         var xmlData:GmActivityInfo = FlowerGivingManager.instance.xmlData;
         var beginDate:String = dateTrim(xmlData.beginTime,true);
         var endDate:String = dateTrim(xmlData.endTime,true);
         var beginShow:String = dateTrim(xmlData.beginShowTime);
         var endShow:String = dateTrim(xmlData.endShowTime);
         _desc.text = LanguageMgr.GetTranslation("flowerGiving.desc",beginDate,endDate,beginShow,endShow);
      }
      
      private function dateTrim(dateStr:String, flag:Boolean = false) : String
      {
         var str:String = "";
         var temp:Array = dateStr.split(" ");
         str = temp[0].replace(/\//g,"-");
         if(flag)
         {
            str = str + (" " + temp[1].slice(0,5));
         }
         return str;
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

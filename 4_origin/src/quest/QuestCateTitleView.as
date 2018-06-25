package quest
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.filters.ColorMatrixFilter;
   
   public class QuestCateTitleView extends Sprite implements Disposeable
   {
       
      
      private var _type:int;
      
      private var _isExpanded:Boolean;
      
      private var rLum:Number = 0.2225;
      
      private var gLum:Number = 0.7169;
      
      private var bLum:Number = 0.0606;
      
      private var bwMatrix:Array;
      
      private var cmf:ColorMatrixFilter;
      
      private var bg:ScaleFrameImage;
      
      private var titleImg:ScaleFrameImage;
      
      private var titleIconImg:ScaleFrameImage;
      
      private var bmpNEW:MovieClip;
      
      private var bmpOK:Bitmap;
      
      private var bmpRecommond:Bitmap;
      
      private var _expandBg:DisplayObject;
      
      public function QuestCateTitleView(cateID:int = 0)
      {
         bwMatrix = [rLum,gLum,bLum,0,0,rLum,gLum,bLum,0,0,rLum,gLum,bLum,0,0,0,0,0,1,0];
         super();
         _type = cateID;
         cmf = new ColorMatrixFilter(bwMatrix);
         initView();
         initEvent();
         isExpanded = false;
      }
      
      override public function get width() : Number
      {
         return bg.width;
      }
      
      override public function get height() : Number
      {
         return bg.height;
      }
      
      private function initView() : void
      {
         buttonMode = true;
         bg = ComponentFactory.Instance.creatComponentByStylename("quest.QuestCateTitleBG");
         addChild(bg);
         bg.setFrame(1);
         titleImg = ComponentFactory.Instance.creat("core.quest.MCQuestCateTitle");
         addChild(titleImg);
         _expandBg = ComponentFactory.Instance.creatCustomObject("asset.core.QuestCateExpandBg");
         _expandBg.visible = false;
         addChild(_expandBg);
         titleIconImg = ComponentFactory.Instance.creat("core.quest.MCQuestCateTitleIcon");
         addChild(titleIconImg);
         titleIconImg.setFrame(_type + 1);
         bmpNEW = ClassUtils.CreatInstance("asset.quest.newMovie") as MovieClip;
         bmpNEW.visible = false;
         addChild(bmpNEW);
         PositionUtils.setPos(bmpNEW,"quest.bmpNEWPos");
         bmpOK = ComponentFactory.Instance.creat("asset.core.quest.textImg.OK");
         bmpOK.visible = false;
         PositionUtils.setPos(bmpOK,"asset.core.questcateTile.okPos");
         addChild(bmpOK);
         bmpRecommond = ComponentFactory.Instance.creatBitmap("asset.core.quest.recommend");
         bmpRecommond.rotation = 15;
         bmpRecommond.smoothing = true;
         PositionUtils.setPos(bmpRecommond,"quest.cateTitleView.recommendPos");
         bmpRecommond.visible = false;
         addChild(bmpRecommond);
      }
      
      private function initEvent() : void
      {
      }
      
      public function set taskStyle(style:int) : void
      {
         bg.setFrame(style);
      }
      
      public function set enable(value:Boolean) : void
      {
         if(!value)
         {
            filters = [cmf];
            buttonMode = false;
            mouseChildren = false;
            mouseEnabled = false;
         }
         else
         {
            filters = null;
            buttonMode = true;
            mouseEnabled = true;
            mouseChildren = true;
         }
      }
      
      public function get isExpanded() : Boolean
      {
         return _isExpanded;
      }
      
      public function set isExpanded(value:Boolean) : void
      {
         _isExpanded = value;
         if(value == true)
         {
            bg.setFrame(2);
            titleImg.setFrame(_type + 10);
         }
         else
         {
            bg.setFrame(1);
            titleImg.setFrame(_type + 1);
         }
         _expandBg.visible = _isExpanded;
      }
      
      public function haveNew() : void
      {
         bmpNEW.visible = true;
         bmpNEW.gotoAndPlay(1);
         bmpOK.visible = false;
         bmpRecommond.visible = false;
      }
      
      public function haveCompleted() : void
      {
         bmpNEW.visible = false;
         bmpOK.visible = true;
         bmpRecommond.visible = false;
      }
      
      public function haveNoTag() : void
      {
         bmpNEW.visible = false;
         bmpOK.visible = false;
         bmpRecommond.visible = false;
      }
      
      public function haveRecommond() : void
      {
         bmpNEW.visible = false;
         bmpOK.visible = false;
         bmpRecommond.visible = true;
      }
      
      public function dispose() : void
      {
         bwMatrix = null;
         cmf = null;
         ObjectUtils.disposeObject(titleIconImg);
         titleIconImg = null;
         if(bg)
         {
            ObjectUtils.disposeObject(bg);
         }
         bg = null;
         if(titleImg)
         {
            ObjectUtils.disposeObject(titleImg);
         }
         titleImg = null;
         if(bmpNEW)
         {
            ObjectUtils.disposeObject(bmpNEW);
         }
         bmpNEW = null;
         if(bmpOK)
         {
            ObjectUtils.disposeObject(bmpOK);
         }
         bmpOK = null;
         if(bmpRecommond)
         {
            ObjectUtils.disposeObject(bmpRecommond);
         }
         bmpRecommond = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

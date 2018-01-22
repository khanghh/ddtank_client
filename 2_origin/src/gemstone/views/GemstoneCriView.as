package gemstone.views
{
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SoundManager;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import gemstone.GemstoneManager;
   import gemstone.info.GemstListInfo;
   import gemstone.info.GemstonInitInfo;
   import gemstone.info.GemstoneStaticInfo;
   import gemstone.info.GemstoneUpGradeInfo;
   import gemstone.items.GemstoneContent;
   import gemstone.items.Item;
   import org.aswing.KeyboardManager;
   
   public class GemstoneCriView extends Sprite implements Disposeable
   {
      
      private static const ANGLE_P1:int = 90;
      
      private static const ANGLE_P2:int = 210;
      
      private static const ANGLE_P3:int = 330;
      
      private static const RADIUS:int = 38;
       
      
      public var data:GemstonInitInfo;
      
      private var _staticDataList:Vector.<GemstoneStaticInfo>;
      
      public var place:int;
      
      private var _contArray:Vector.<GemstoneContent>;
      
      private var _centerP:Point;
      
      private var _item:Item;
      
      private var _point1:Point;
      
      private var _point2:Point;
      
      private var _point3:Point;
      
      private var _pointArray:Array;
      
      private var _startPointArr:Array;
      
      private var _funArray:Array;
      
      private var _func1:Function;
      
      private var _func2:Function;
      
      private var _func3:Function;
      
      private var _lightning:MovieClip;
      
      private var _bombo:MovieClip;
      
      private var _groudMc:MovieClip;
      
      private var _upGradeMc:MovieClip;
      
      private var _isLeft:Boolean = false;
      
      private var _index:int;
      
      private var _minGemstone:Array;
      
      private var _midGemstone:Array;
      
      private var _maxGemstone:Array;
      
      private var _curItem:GemstoneContent;
      
      public var curIndex:int;
      
      public var curInfo:GemstListInfo;
      
      public var curList:Vector.<GemstListInfo>;
      
      private var _info:GemstoneUpGradeInfo;
      
      private var _isAction:Boolean;
      
      private var curInfoList:Vector.<GemstListInfo>;
      
      private var PRICE:int = 10;
      
      private var _bgGoldenShiningAnimation:MovieClip;
      
      private const MAX_LEVEL:int = 6;
      
      public function GemstoneCriView()
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         var _loc1_:* = null;
         _centerP = new Point(0,0);
         super();
         _pointArray = [];
         _startPointArr = [];
         _funArray = [];
         _contArray = new Vector.<GemstoneContent>();
         _loc3_ = 0;
         while(_loc3_ < 3)
         {
            _loc2_ = new GemstoneContent(_loc3_,_centerP);
            _loc2_.id = _loc3_ + 1;
            addChild(_loc2_);
            _contArray.push(_loc2_);
            _loc1_ = new Point(_loc2_.x,_loc2_.y);
            _startPointArr.push(_loc1_);
            _loc3_++;
         }
         _item = new Item();
         _item.x = -105;
         _item.y = -105;
         addChild(_item);
         _func1 = completedHander1;
         _func2 = completedHander2;
         _func3 = completedHander3;
         _funArray.push(_func1);
         _funArray.push(_func2);
         _funArray.push(_func3);
         _point1 = new Point();
         _point1.x = Math.round(_centerP.x + Math.cos(90 * (3.14159265358979 / 180)) * 38);
         _point1.y = Math.round(_centerP.y - Math.sin(90 * (3.14159265358979 / 180)) * 38);
         _pointArray.push(_point1);
         _point2 = new Point();
         _point2.x = Math.round(_centerP.x + Math.cos(210 * (3.14159265358979 / 180)) * 38);
         _point2.y = Math.round(_centerP.y - Math.sin(210 * (3.14159265358979 / 180)) * 38);
         _pointArray.push(_point2);
         _point3 = new Point();
         _point3.x = Math.round(_centerP.x + Math.cos(330 * (3.14159265358979 / 180)) * 38);
         _point3.y = Math.round(_centerP.y - Math.sin(330 * (3.14159265358979 / 180)) * 38);
         _pointArray.push(_point3);
         _lightning = ComponentFactory.Instance.creat("gemstone.shandian");
         _lightning.x = -44;
         _lightning.y = -38;
         _lightning.gotoAndStop(_lightning.totalFrames);
         _lightning.visible = false;
         addChild(_lightning);
         _bombo = ComponentFactory.Instance.creat("gemstone.bombo");
         _bombo.x = -76;
         _bombo.y = -78;
         _bombo.gotoAndStop(_bombo.totalFrames);
         _bombo.visible = false;
         addChild(_bombo);
         _groudMc = ComponentFactory.Instance.creat("gemstone.groudMC");
         _groudMc.x = -39;
         _groudMc.y = -32;
         _groudMc.gotoAndStop(_groudMc.totalFrames);
         _groudMc.visible = false;
         addChild(_groudMc);
         _upGradeMc = ComponentFactory.Instance.creat("gemstone.upGradeMc");
         _upGradeMc.gotoAndStop(_upGradeMc.totalFrames);
         _upGradeMc.x = -76;
         _upGradeMc.y = 23;
         _upGradeMc.visible = false;
         addChild(_upGradeMc);
         _bgGoldenShiningAnimation = ComponentFactory.Instance.creat("gemstone.bg.mc");
         _bgGoldenShiningAnimation.mouseEnabled = false;
         _bgGoldenShiningAnimation.stop();
         addChild(_bgGoldenShiningAnimation);
         _bgGoldenShiningAnimation.x = -171;
         _bgGoldenShiningAnimation.y = -170;
      }
      
      public function upDataIcon(param1:ItemTemplateInfo) : void
      {
         _item.upDataIcon(param1);
      }
      
      public function initFigSkin(param1:String) : void
      {
         _contArray[0].loadSikn(param1);
         _contArray[1].loadSikn(param1);
         _contArray[2].loadSikn(param1);
         _contArray[0].selAlphe(0.4);
         _contArray[1].selAlphe(0.4);
         _contArray[2].selAlphe(0.4);
      }
      
      public function resetGemstoneList(param1:Vector.<GemstListInfo>) : void
      {
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:int = param1.length;
         _loc6_ = 0;
         while(_loc6_ < _loc4_)
         {
            _contArray[_loc6_].x = _startPointArr[_loc6_].x;
            _contArray[_loc6_].y = _startPointArr[_loc6_].y;
            _loc6_++;
         }
         _loc5_ = 0;
         while(_loc5_ < 3 && _loc5_ < _loc4_)
         {
            if(param1[_loc5_].place == 0)
            {
               _contArray[0].info = param1[_loc5_];
               if(param1[_loc5_].level > 0)
               {
                  _contArray[0].selAlphe(1);
               }
               else
               {
                  _contArray[0].selAlphe(0.4);
               }
               _contArray[0].upDataLevel();
            }
            else if(param1[_loc5_].place == 1)
            {
               _contArray[1].info = param1[_loc5_];
               if(param1[_loc5_].level > 0)
               {
                  _contArray[1].selAlphe(1);
               }
               else
               {
                  _contArray[1].selAlphe(0.4);
               }
               _contArray[1].upDataLevel();
            }
            else if(param1[_loc5_].place == 2)
            {
               _contArray[2].info = param1[_loc5_];
               if(param1[_loc5_].level > 0)
               {
                  _contArray[2].selAlphe(1);
               }
               else
               {
                  _contArray[2].selAlphe(0.4);
               }
               _contArray[2].upDataLevel();
               curInfo = param1[_loc5_];
               _curItem = _contArray[2];
            }
            _contArray[_loc5_].setBG();
            _loc5_++;
         }
         _item.updataInfo(param1);
         curIndex = curInfo.place;
         var _loc3_:int = curInfo.level;
         setCurInfo(param1[0].fightSpiritId,_loc3_);
         if(_loc3_ >= 6)
         {
            _loc3_ = 6;
            _loc2_ = staticDataList[_loc3_].Exp - staticDataList[_loc3_ - 1].Exp;
            GemstoneUpView(parent).expBar.initBar(_loc2_,_loc2_,true);
            return;
         }
         _loc3_++;
         _loc2_ = staticDataList[_loc3_].Exp - staticDataList[_loc3_ - 1].Exp;
         GemstoneUpView(parent).expBar.initBar(curInfo.exp,_loc2_);
      }
      
      public function updateContentBG() : void
      {
         var _loc3_:int = 0;
         var _loc1_:Boolean = true;
         var _loc2_:int = _contArray.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _contArray[_loc3_].setBG();
            if(_contArray[_loc3_].info.level < 6)
            {
               _loc1_ = false;
            }
            _loc3_++;
         }
         isAllGoden(_loc1_);
      }
      
      public function changeGhostColorAnimationPlay() : void
      {
         var _loc1_:Boolean = true;
         var _loc4_:int = 0;
         var _loc3_:* = _contArray;
         for each(var _loc2_ in _contArray)
         {
            if(_loc2_.info.place == 2)
            {
               _loc2_.changeBG(startUpGradeAnimation);
            }
            else
            {
               _loc2_.setBG();
            }
            if(_loc2_.info.level < 6)
            {
               _loc1_ = false;
            }
         }
         isAllGoden(_loc1_);
      }
      
      private function isAllGoden(param1:Boolean) : void
      {
         if(param1)
         {
            addChildAt(_bgGoldenShiningAnimation,0);
            _bgGoldenShiningAnimation.play();
         }
         else
         {
            _bgGoldenShiningAnimation.parent && removeChild(_bgGoldenShiningAnimation);
            _bgGoldenShiningAnimation.stop();
         }
      }
      
      private function setCurInfo(param1:int, param2:int) : void
      {
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc5_:Object = {};
         _loc5_.curLve = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.pdescriptTxt1") + param2;
         _loc5_.levHe = int(_contArray[0].info.level) + int(_contArray[1].info.level) + int(_contArray[2].info.level);
         if(param1 == 100001)
         {
            _loc6_ = staticDataList[_contArray[0].info.level].attack;
            _loc4_ = staticDataList[_contArray[1].info.level].attack;
            _loc3_ = staticDataList[_contArray[2].info.level].attack;
            if(param2 >= 6)
            {
               param2 = 6;
            }
            _loc5_.upGrdPro = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.pdescriptTxt3") + staticDataList[param2].attack;
         }
         else if(param1 == 100002)
         {
            _loc6_ = staticDataList[_contArray[0].info.level].defence;
            _loc4_ = staticDataList[_contArray[1].info.level].defence;
            _loc3_ = staticDataList[_contArray[2].info.level].defence;
            if(param2 >= 6)
            {
               param2 = 6;
            }
            _loc5_.upGrdPro = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.pdescriptTxt3") + staticDataList[param2].defence;
         }
         else if(param1 == 100003)
         {
            _loc6_ = staticDataList[_contArray[0].info.level].agility;
            _loc4_ = staticDataList[_contArray[1].info.level].agility;
            _loc3_ = staticDataList[_contArray[2].info.level].agility;
            if(param2 >= 6)
            {
               param2 = 6;
            }
            _loc5_.upGrdPro = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.pdescriptTxt3") + staticDataList[param2].agility;
         }
         else if(param1 == 100004)
         {
            _loc6_ = staticDataList[_contArray[0].info.level].luck;
            _loc4_ = staticDataList[_contArray[1].info.level].luck;
            _loc3_ = staticDataList[_contArray[2].info.level].luck;
            if(param2 >= 6)
            {
               param2 = 6;
            }
            _loc5_.upGrdPro = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.pdescriptTxt3") + staticDataList[param2].luck;
         }
         _loc5_.proHe = _loc6_ + _loc4_ + _loc3_;
         (parent as GemstoneUpView).upDataCur(_loc5_);
      }
      
      public function upGradeAction(param1:GemstoneUpGradeInfo) : void
      {
         var _loc3_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         if(param1.list.length == 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.gemstone.curInfo.notEquip"));
            GemstoneManager.Instance.gemstoneFrame.getMaskMc().visible = false;
            KeyboardManager.getInstance().isStopDispatching = false;
            return;
         }
         _info = param1;
         if(_info.isMaxLevel)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.gemstone.curInfo.maxLevel"));
            GemstoneManager.Instance.gemstoneFrame.getMaskMc().visible = false;
            return;
         }
         if(curInfo == null)
         {
            _loc3_ = 0;
         }
         else
         {
            _loc3_ = curInfo.level;
         }
         if(!param1.isUp)
         {
            if(!param1.isFall)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.gemstone.curInfo.notfit"));
               GemstoneManager.Instance.gemstoneFrame.getMaskMc().visible = false;
               return;
            }
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.gemstone.curInfo.upgradeExp",param1.num * PRICE));
            _loc5_ = 0;
            while(_loc5_ < 3)
            {
               if(param1.list[_loc5_].place == 2)
               {
                  if(curInfo)
                  {
                     GemstoneManager.Instance.gemstoneFrame.getMaskMc().visible = false;
                     curInfo = param1.list[_loc5_];
                  }
                  else
                  {
                     curInfo = new GemstListInfo();
                     curInfo = param1.list[_loc5_];
                  }
                  break;
               }
               _loc5_++;
            }
            _loc3_++;
            if(_loc3_ >= 6)
            {
               _loc3_ = 6;
            }
            _loc4_ = staticDataList[_loc3_].Exp - staticDataList[_loc3_ - 1].Exp;
            GemstoneManager.Instance.expBar.initBar(curInfo.exp,_loc4_);
            return;
         }
         if(param1.dir == 0)
         {
            _isLeft = false;
            _isAction = true;
         }
         else if(param1.dir == 1)
         {
            _isLeft = true;
            _isAction = true;
         }
         else if(param1.dir == 2)
         {
            _isAction = false;
         }
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.gemstone.curInfo.succe"));
         _curItem.info.level++;
         _loc3_ = _curItem.info.level;
         _curItem.upDataLevel();
         _upGradeMc.visible = true;
         _upGradeMc.gotoAndPlay(1);
         var _loc2_:int = staticDataList[_loc3_].Exp - staticDataList[_loc3_ - 1].Exp;
         GemstoneManager.Instance.expBar.initBar(_loc2_,_loc2_);
         if(_loc3_ >= 6)
         {
            changeGhostColorAnimationPlay();
         }
         else
         {
            startUpGradeAnimation();
         }
      }
      
      private function startUpGradeAnimation() : void
      {
         addEventListener("enterFrame",enterframeHander);
      }
      
      private function init() : void
      {
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:Array = [];
         _loc5_ = 0;
         while(_loc5_ < 3)
         {
            _contArray[_loc5_].x = _startPointArr[_loc5_].x;
            _contArray[_loc5_].y = _startPointArr[_loc5_].y;
            _loc5_++;
         }
         _loc4_ = 0;
         while(_loc4_ < 3)
         {
            if(_info.list[_loc4_].place == 0)
            {
               _contArray[0].info = _info.list[_loc4_];
               if(_info.list[_loc4_].level > 0)
               {
                  _contArray[0].selAlphe(1);
               }
               else
               {
                  _contArray[0].selAlphe(0.4);
               }
               _contArray[0].upDataLevel();
            }
            else if(_info.list[_loc4_].place == 1)
            {
               _contArray[1].info = _info.list[_loc4_];
               if(_info.list[_loc4_].level > 0)
               {
                  _contArray[1].selAlphe(1);
               }
               else
               {
                  _contArray[1].selAlphe(0.4);
               }
               _contArray[1].upDataLevel();
            }
            else if(_info.list[_loc4_].place == 2)
            {
               _contArray[2].info = _info.list[_loc4_];
               if(_info.list[_loc4_].level > 0)
               {
                  _contArray[2].selAlphe(1);
               }
               else
               {
                  _contArray[2].selAlphe(0.4);
               }
               _contArray[2].upDataLevel();
               curInfo = _info.list[_loc4_];
            }
            _contArray[_loc4_].setBG();
            _loc4_++;
         }
         curInfoList = _info.list;
         var _loc2_:int = curInfo.level;
         setCurInfo(curInfo.fightSpiritId,_loc2_);
         _item.updataInfo(curInfoList);
         _loc2_++;
         if(_loc2_ >= 6)
         {
            _loc2_ = 6;
         }
         var _loc1_:int = staticDataList[_loc2_].Exp - staticDataList[_loc2_ - 1].Exp;
         GemstoneManager.Instance.expBar.initBar(curInfo.exp,_loc1_);
         GemstoneManager.Instance.gemstoneFrame.getMaskMc().visible = false;
         updateContentBG();
      }
      
      public function gemstoAction() : void
      {
         var _loc8_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc7_:int = 0;
         var _loc6_:int = 0;
         var _loc1_:int = 0;
         var _loc2_:* = 0;
         var _loc3_:int = _contArray.length;
         if(!_isLeft)
         {
            if(_contArray[0].x == _startPointArr[2].x)
            {
               _loc8_ = 0;
               while(_loc8_ < 3)
               {
                  if(_loc8_ == 0)
                  {
                     _loc2_ = 1;
                  }
                  else if(_loc8_ == 1)
                  {
                     _loc2_ = 2;
                  }
                  else if(_loc8_ == 2)
                  {
                     _loc2_ = 0;
                  }
                  TweenLite.to(_contArray[_loc8_],0.5,{
                     "x":_pointArray[_loc2_].x,
                     "y":_pointArray[_loc2_].y,
                     "onComplete":_funArray[_loc8_]
                  });
                  _loc8_++;
               }
            }
            else if(_contArray[0].x == _startPointArr[1].x)
            {
               _loc4_ = 0;
               while(_loc4_ < 3)
               {
                  _loc2_ = _loc4_;
                  TweenLite.to(_contArray[_loc4_],0.5,{
                     "x":_pointArray[_loc2_].x,
                     "y":_pointArray[_loc2_].y,
                     "onComplete":_funArray[_loc4_]
                  });
                  _loc4_++;
               }
            }
            else if(_contArray[0].x == _startPointArr[0].x)
            {
               _loc5_ = 0;
               while(_loc5_ < 3)
               {
                  if(_loc5_ == 0)
                  {
                     _loc2_ = 2;
                  }
                  else if(_loc5_ == 1)
                  {
                     _loc2_ = 0;
                  }
                  else if(_loc5_ == 2)
                  {
                     _loc2_ = 1;
                  }
                  TweenLite.to(_contArray[_loc5_],0.5,{
                     "x":_pointArray[_loc2_].x,
                     "y":_pointArray[_loc2_].y,
                     "onComplete":_funArray[_loc5_]
                  });
                  _loc5_++;
               }
            }
            return;
         }
         if(_contArray[0].x == _startPointArr[0].x)
         {
            _loc7_ = 0;
            while(_loc7_ < 3)
            {
               _loc2_ = _loc7_;
               TweenLite.to(_contArray[_loc7_],0.5,{
                  "x":_pointArray[_loc2_].x,
                  "y":_pointArray[_loc2_].y,
                  "onComplete":_funArray[_loc7_]
               });
               _loc7_++;
            }
         }
         else if(_contArray[0].x == _startPointArr[1].x)
         {
            _loc6_ = 0;
            while(_loc6_ < 3)
            {
               _loc2_ = int(_loc6_ + 1);
               if(_loc2_ > 2)
               {
                  _loc2_ = 0;
               }
               TweenLite.to(_contArray[_loc6_],0.5,{
                  "x":_pointArray[_loc2_].x,
                  "y":_pointArray[_loc2_].y,
                  "onComplete":_funArray[_loc6_]
               });
               _loc6_++;
            }
         }
         else if(_contArray[0].x == _startPointArr[2].x)
         {
            _loc1_ = 0;
            while(_loc1_ < 3)
            {
               if(_loc1_ == 0)
               {
                  _loc2_ = 2;
               }
               else
               {
                  _loc2_ = int(_loc1_ - 1);
               }
               TweenLite.to(_contArray[_loc1_],0.5,{
                  "x":_pointArray[_loc2_].x,
                  "y":_pointArray[_loc2_].y,
                  "onComplete":_funArray[_loc1_]
               });
               _loc1_++;
            }
         }
      }
      
      private function completedHander1() : void
      {
         if(!_isLeft)
         {
            if(_contArray[0].x == _pointArray[0].x)
            {
               TweenLite.to(_contArray[0],0.5,{
                  "x":_startPointArr[0].x,
                  "y":_startPointArr[0].y,
                  "onComplete":lightningPlay
               });
            }
            else if(_contArray[0].x == _pointArray[2].x)
            {
               TweenLite.to(_contArray[0],0.5,{
                  "x":_startPointArr[2].x,
                  "y":_startPointArr[2].y,
                  "onComplete":lightningPlay
               });
            }
            else if(_contArray[0].x == _pointArray[1].x)
            {
               TweenLite.to(_contArray[0],0.5,{
                  "x":_startPointArr[1].x,
                  "y":_startPointArr[1].y,
                  "onComplete":lightningPlay
               });
            }
            return;
         }
         if(_contArray[0].x == _pointArray[0].x)
         {
            TweenLite.to(_contArray[0],0.5,{
               "x":_startPointArr[1].x,
               "y":_startPointArr[1].y,
               "onComplete":lightningPlay
            });
         }
         else if(_contArray[0].x == _pointArray[1].x)
         {
            TweenLite.to(_contArray[0],0.5,{
               "x":_startPointArr[2].x,
               "y":_startPointArr[2].y,
               "onComplete":lightningPlay
            });
         }
         else if(_contArray[0].x == _pointArray[2].x)
         {
            TweenLite.to(_contArray[0],0.5,{
               "x":_startPointArr[0].x,
               "y":_startPointArr[0].y,
               "onComplete":lightningPlay
            });
         }
      }
      
      private function lightningPlay() : void
      {
         if(!_lightning)
         {
            return;
         }
         _lightning.visible = true;
         _lightning.gotoAndPlay(1);
         SoundManager.instance.stop("169");
         SoundManager.instance.stop("170");
         SoundManager.instance.play("168");
      }
      
      private function enterframeHander(param1:Event) : void
      {
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         if(_upGradeMc.currentFrame == _upGradeMc.totalFrames - 1)
         {
            _upGradeMc.visible = false;
            _upGradeMc.gotoAndStop(_upGradeMc.totalFrames);
            SoundManager.instance.stop("170");
            SoundManager.instance.play("169");
            _loc4_ = _contArray.length;
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               if(_contArray[_loc5_].info.level > 0)
               {
                  _contArray[_loc5_].selAlphe(1);
                  _contArray[_loc5_].upDataLevel();
               }
               _loc5_++;
            }
            if(_isAction)
            {
               gemstoAction();
            }
            else
            {
               _loc3_ = curInfo.level;
               if(_loc3_ >= 6)
               {
                  _loc3_ = 6;
                  _loc2_ = staticDataList[_loc3_].Exp - staticDataList[_loc3_ - 1].Exp;
                  GemstoneManager.Instance.expBar.initBar(_loc2_,_loc2_,true);
                  GemstoneManager.Instance.gemstoneFrame.getMaskMc().visible = false;
                  return;
               }
               setCurInfo(curInfo.fightSpiritId,_loc3_);
               _loc3_++;
               _loc2_ = staticDataList[_loc3_].Exp - staticDataList[_loc3_ - 1].Exp;
               GemstoneManager.Instance.expBar.initBar(0,_loc2_);
               GemstoneManager.Instance.gemstoneFrame.getMaskMc().visible = false;
            }
         }
         if(_lightning.currentFrame == _lightning.totalFrames - 1)
         {
            _lightning.visible = false;
            _lightning.gotoAndStop(_lightning.totalFrames);
            _bombo.visible = true;
            _bombo.gotoAndPlay(1);
            _groudMc.visible = true;
            _groudMc.gotoAndPlay(1);
         }
         if(_groudMc.currentFrame == _groudMc.totalFrames - 1)
         {
            _groudMc.visible = false;
            _groudMc.gotoAndStop(_groudMc.totalFrames);
            init();
            removeEventListener("enterFrame",enterframeHander);
         }
         if(_bombo.currentFrame == _bombo.totalFrames - 1)
         {
            _bombo.visible = false;
            _bombo.gotoAndStop(_bombo.totalFrames);
         }
      }
      
      private function completedHander2() : void
      {
         if(!_isLeft)
         {
            if(_contArray[0].x == _pointArray[0].x)
            {
               TweenLite.to(_contArray[1],0.5,{
                  "x":_startPointArr[1].x,
                  "y":_startPointArr[1].y
               });
            }
            else if(_contArray[0].x == _pointArray[2].x)
            {
               TweenLite.to(_contArray[1],0.5,{
                  "x":_startPointArr[0].x,
                  "y":_startPointArr[0].y
               });
            }
            else if(_contArray[0].x == _pointArray[1].x)
            {
               TweenLite.to(_contArray[1],0.5,{
                  "x":_startPointArr[2].x,
                  "y":_startPointArr[2].y
               });
            }
            return;
         }
         if(_contArray[0].x == _pointArray[0].x)
         {
            TweenLite.to(_contArray[1],0.5,{
               "x":_startPointArr[2].x,
               "y":_startPointArr[2].y
            });
         }
         else if(_contArray[0].x == _pointArray[1].x)
         {
            TweenLite.to(_contArray[1],0.5,{
               "x":_startPointArr[0].x,
               "y":_startPointArr[0].y
            });
         }
         else if(_contArray[0].x == _pointArray[2].x)
         {
            TweenLite.to(_contArray[1],0.5,{
               "x":_startPointArr[1].x,
               "y":_startPointArr[1].y
            });
         }
      }
      
      private function completedHander3() : void
      {
         if(!_isLeft)
         {
            if(_contArray[0].x == _pointArray[0].x)
            {
               TweenLite.to(_contArray[2],0.5,{
                  "x":_startPointArr[2].x,
                  "y":_startPointArr[2].y
               });
            }
            else if(_contArray[0].x == _pointArray[2].x)
            {
               TweenLite.to(_contArray[2],0.5,{
                  "x":_startPointArr[1].x,
                  "y":_startPointArr[1].y
               });
            }
            else if(_contArray[0].x == _pointArray[1].x)
            {
               TweenLite.to(_contArray[2],0.5,{
                  "x":_startPointArr[0].x,
                  "y":_startPointArr[0].y
               });
            }
            return;
         }
         if(_contArray[0].x == _pointArray[0].x)
         {
            TweenLite.to(_contArray[2],0.5,{
               "x":_startPointArr[0].x,
               "y":_startPointArr[0].y
            });
         }
         else if(_contArray[0].x == _pointArray[1].x)
         {
            TweenLite.to(_contArray[2],0.5,{
               "x":_startPointArr[1].x,
               "y":_startPointArr[1].y
            });
         }
         else if(_contArray[0].x == _pointArray[2].x)
         {
            TweenLite.to(_contArray[2],0.5,{
               "x":_startPointArr[2].x,
               "y":_startPointArr[2].y
            });
         }
      }
      
      public function dispose() : void
      {
         removeEventListener("enterFrame",enterframeHander);
         if(_lightning)
         {
            _lightning.gotoAndStop(_lightning.totalFrames);
         }
         ObjectUtils.disposeObject(_lightning);
         _lightning = null;
         if(_bombo)
         {
            _bombo.gotoAndStop(_bombo.totalFrames);
         }
         ObjectUtils.disposeObject(_bombo);
         _bombo = null;
         if(_groudMc)
         {
            _groudMc.gotoAndStop(_groudMc.totalFrames);
         }
         ObjectUtils.disposeObject(_groudMc);
         _groudMc = null;
         if(_upGradeMc)
         {
            _upGradeMc.gotoAndStop(_upGradeMc.totalFrames);
         }
         ObjectUtils.disposeObject(_upGradeMc);
         _upGradeMc = null;
         var _loc3_:int = 0;
         var _loc2_:* = _contArray;
         for each(var _loc1_ in _contArray)
         {
            if(_loc1_)
            {
               TweenLite.killTweensOf(_loc1_,true);
            }
            ObjectUtils.disposeObject(_loc1_);
         }
         _contArray = null;
         staticDataList = null;
         curInfoList = null;
         _info = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function get staticDataList() : Vector.<GemstoneStaticInfo>
      {
         return _staticDataList;
      }
      
      public function set staticDataList(param1:Vector.<GemstoneStaticInfo>) : void
      {
         _staticDataList = param1;
      }
   }
}

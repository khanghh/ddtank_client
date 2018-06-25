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
         var i:int = 0;
         var gemCont:* = null;
         var p:* = null;
         _centerP = new Point(0,0);
         super();
         _pointArray = [];
         _startPointArr = [];
         _funArray = [];
         _contArray = new Vector.<GemstoneContent>();
         for(i = 0; i < 3; )
         {
            gemCont = new GemstoneContent(i,_centerP);
            gemCont.id = i + 1;
            addChild(gemCont);
            _contArray.push(gemCont);
            p = new Point(gemCont.x,gemCont.y);
            _startPointArr.push(p);
            i++;
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
      
      public function upDataIcon(info:ItemTemplateInfo) : void
      {
         _item.upDataIcon(info);
      }
      
      public function initFigSkin(str:String) : void
      {
         _contArray[0].loadSikn(str);
         _contArray[1].loadSikn(str);
         _contArray[2].loadSikn(str);
         _contArray[0].selAlphe(0.4);
         _contArray[1].selAlphe(0.4);
         _contArray[2].selAlphe(0.4);
      }
      
      public function resetGemstoneList(list:Vector.<GemstListInfo>) : void
      {
         var i:int = 0;
         var t_j:int = 0;
         var total:int = 0;
         var len:int = list.length;
         for(i = 0; i < len; )
         {
            _contArray[i].x = _startPointArr[i].x;
            _contArray[i].y = _startPointArr[i].y;
            i++;
         }
         t_j = 0;
         while(t_j < 3 && t_j < len)
         {
            if(list[t_j].place == 0)
            {
               _contArray[0].info = list[t_j];
               if(list[t_j].level > 0)
               {
                  _contArray[0].selAlphe(1);
               }
               else
               {
                  _contArray[0].selAlphe(0.4);
               }
               _contArray[0].upDataLevel();
            }
            else if(list[t_j].place == 1)
            {
               _contArray[1].info = list[t_j];
               if(list[t_j].level > 0)
               {
                  _contArray[1].selAlphe(1);
               }
               else
               {
                  _contArray[1].selAlphe(0.4);
               }
               _contArray[1].upDataLevel();
            }
            else if(list[t_j].place == 2)
            {
               _contArray[2].info = list[t_j];
               if(list[t_j].level > 0)
               {
                  _contArray[2].selAlphe(1);
               }
               else
               {
                  _contArray[2].selAlphe(0.4);
               }
               _contArray[2].upDataLevel();
               curInfo = list[t_j];
               _curItem = _contArray[2];
            }
            _contArray[t_j].setBG();
            t_j++;
         }
         _item.updataInfo(list);
         curIndex = curInfo.place;
         var level:int = curInfo.level;
         setCurInfo(list[0].fightSpiritId,level);
         if(level >= 6)
         {
            level = 6;
            total = staticDataList[level].Exp - staticDataList[level - 1].Exp;
            GemstoneUpView(parent).expBar.initBar(total,total,true);
            return;
         }
         level++;
         total = staticDataList[level].Exp - staticDataList[level - 1].Exp;
         GemstoneUpView(parent).expBar.initBar(curInfo.exp,total);
      }
      
      public function updateContentBG() : void
      {
         var i:int = 0;
         var _isAllGolden:Boolean = true;
         var len:int = _contArray.length;
         for(i = 0; i < len; )
         {
            _contArray[i].setBG();
            if(_contArray[i].info.level < 6)
            {
               _isAllGolden = false;
            }
            i++;
         }
         isAllGoden(_isAllGolden);
      }
      
      public function changeGhostColorAnimationPlay() : void
      {
         var _isAllGolden:Boolean = true;
         var _loc4_:int = 0;
         var _loc3_:* = _contArray;
         for each(var item in _contArray)
         {
            if(item.info.place == 2)
            {
               item.changeBG(startUpGradeAnimation);
            }
            else
            {
               item.setBG();
            }
            if(item.info.level < 6)
            {
               _isAllGolden = false;
            }
         }
         isAllGoden(_isAllGolden);
      }
      
      private function isAllGoden(result:Boolean) : void
      {
         if(result)
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
      
      private function setCurInfo(id:int, level:int) : void
      {
         var pro1:int = 0;
         var pro2:int = 0;
         var pro3:int = 0;
         var obj:Object = {};
         obj.curLve = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.pdescriptTxt1") + level;
         obj.levHe = int(_contArray[0].info.level) + int(_contArray[1].info.level) + int(_contArray[2].info.level);
         if(id == 100001)
         {
            pro1 = staticDataList[_contArray[0].info.level].attack;
            pro2 = staticDataList[_contArray[1].info.level].attack;
            pro3 = staticDataList[_contArray[2].info.level].attack;
            if(level >= 6)
            {
               level = 6;
            }
            obj.upGrdPro = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.pdescriptTxt3") + staticDataList[level].attack;
         }
         else if(id == 100002)
         {
            pro1 = staticDataList[_contArray[0].info.level].defence;
            pro2 = staticDataList[_contArray[1].info.level].defence;
            pro3 = staticDataList[_contArray[2].info.level].defence;
            if(level >= 6)
            {
               level = 6;
            }
            obj.upGrdPro = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.pdescriptTxt3") + staticDataList[level].defence;
         }
         else if(id == 100003)
         {
            pro1 = staticDataList[_contArray[0].info.level].agility;
            pro2 = staticDataList[_contArray[1].info.level].agility;
            pro3 = staticDataList[_contArray[2].info.level].agility;
            if(level >= 6)
            {
               level = 6;
            }
            obj.upGrdPro = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.pdescriptTxt3") + staticDataList[level].agility;
         }
         else if(id == 100004)
         {
            pro1 = staticDataList[_contArray[0].info.level].luck;
            pro2 = staticDataList[_contArray[1].info.level].luck;
            pro3 = staticDataList[_contArray[2].info.level].luck;
            if(level >= 6)
            {
               level = 6;
            }
            obj.upGrdPro = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.pdescriptTxt3") + staticDataList[level].luck;
         }
         obj.proHe = pro1 + pro2 + pro3;
         (parent as GemstoneUpView).upDataCur(obj);
      }
      
      public function upGradeAction(info:GemstoneUpGradeInfo) : void
      {
         var level:int = 0;
         var dist:int = 0;
         var i:int = 0;
         var total1:int = 0;
         if(info.list.length == 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.gemstone.curInfo.notEquip"));
            GemstoneManager.Instance.gemstoneFrame.getMaskMc().visible = false;
            KeyboardManager.getInstance().isStopDispatching = false;
            return;
         }
         _info = info;
         if(_info.isMaxLevel)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.gemstone.curInfo.maxLevel"));
            GemstoneManager.Instance.gemstoneFrame.getMaskMc().visible = false;
            return;
         }
         if(curInfo == null)
         {
            level = 0;
         }
         else
         {
            level = curInfo.level;
         }
         if(!info.isUp)
         {
            if(!info.isFall)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.gemstone.curInfo.notfit"));
               GemstoneManager.Instance.gemstoneFrame.getMaskMc().visible = false;
               return;
            }
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.gemstone.curInfo.upgradeExp",info.num * PRICE));
            for(i = 0; i < 3; )
            {
               if(info.list[i].place == 2)
               {
                  if(curInfo)
                  {
                     GemstoneManager.Instance.gemstoneFrame.getMaskMc().visible = false;
                     curInfo = info.list[i];
                  }
                  else
                  {
                     curInfo = new GemstListInfo();
                     curInfo = info.list[i];
                  }
                  break;
               }
               i++;
            }
            level++;
            if(level >= 6)
            {
               level = 6;
            }
            total1 = staticDataList[level].Exp - staticDataList[level - 1].Exp;
            GemstoneManager.Instance.expBar.initBar(curInfo.exp,total1);
            return;
         }
         if(info.dir == 0)
         {
            _isLeft = false;
            _isAction = true;
         }
         else if(info.dir == 1)
         {
            _isLeft = true;
            _isAction = true;
         }
         else if(info.dir == 2)
         {
            _isAction = false;
         }
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.gemstone.curInfo.succe"));
         _curItem.info.level++;
         level = _curItem.info.level;
         _curItem.upDataLevel();
         _upGradeMc.visible = true;
         _upGradeMc.gotoAndPlay(1);
         var total:int = staticDataList[level].Exp - staticDataList[level - 1].Exp;
         GemstoneManager.Instance.expBar.initBar(total,total);
         if(level >= 6)
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
         var t_i:int = 0;
         var t_j:int = 0;
         var arr:Array = [];
         for(t_i = 0; t_i < 3; )
         {
            _contArray[t_i].x = _startPointArr[t_i].x;
            _contArray[t_i].y = _startPointArr[t_i].y;
            t_i++;
         }
         for(t_j = 0; t_j < 3; )
         {
            if(_info.list[t_j].place == 0)
            {
               _contArray[0].info = _info.list[t_j];
               if(_info.list[t_j].level > 0)
               {
                  _contArray[0].selAlphe(1);
               }
               else
               {
                  _contArray[0].selAlphe(0.4);
               }
               _contArray[0].upDataLevel();
            }
            else if(_info.list[t_j].place == 1)
            {
               _contArray[1].info = _info.list[t_j];
               if(_info.list[t_j].level > 0)
               {
                  _contArray[1].selAlphe(1);
               }
               else
               {
                  _contArray[1].selAlphe(0.4);
               }
               _contArray[1].upDataLevel();
            }
            else if(_info.list[t_j].place == 2)
            {
               _contArray[2].info = _info.list[t_j];
               if(_info.list[t_j].level > 0)
               {
                  _contArray[2].selAlphe(1);
               }
               else
               {
                  _contArray[2].selAlphe(0.4);
               }
               _contArray[2].upDataLevel();
               curInfo = _info.list[t_j];
            }
            _contArray[t_j].setBG();
            t_j++;
         }
         curInfoList = _info.list;
         var level:int = curInfo.level;
         setCurInfo(curInfo.fightSpiritId,level);
         _item.updataInfo(curInfoList);
         level++;
         if(level >= 6)
         {
            level = 6;
         }
         var total:int = staticDataList[level].Exp - staticDataList[level - 1].Exp;
         GemstoneManager.Instance.expBar.initBar(curInfo.exp,total);
         GemstoneManager.Instance.gemstoneFrame.getMaskMc().visible = false;
         updateContentBG();
      }
      
      public function gemstoAction() : void
      {
         var i:int = 0;
         var j:int = 0;
         var k:int = 0;
         var t_i:int = 0;
         var t_j:int = 0;
         var t_k:int = 0;
         var index1:* = 0;
         var cLen:int = _contArray.length;
         if(!_isLeft)
         {
            if(_contArray[0].x == _startPointArr[2].x)
            {
               for(i = 0; i < 3; )
               {
                  if(i == 0)
                  {
                     index1 = 1;
                  }
                  else if(i == 1)
                  {
                     index1 = 2;
                  }
                  else if(i == 2)
                  {
                     index1 = 0;
                  }
                  TweenLite.to(_contArray[i],0.5,{
                     "x":_pointArray[index1].x,
                     "y":_pointArray[index1].y,
                     "onComplete":_funArray[i]
                  });
                  i++;
               }
            }
            else if(_contArray[0].x == _startPointArr[1].x)
            {
               for(j = 0; j < 3; )
               {
                  index1 = j;
                  TweenLite.to(_contArray[j],0.5,{
                     "x":_pointArray[index1].x,
                     "y":_pointArray[index1].y,
                     "onComplete":_funArray[j]
                  });
                  j++;
               }
            }
            else if(_contArray[0].x == _startPointArr[0].x)
            {
               for(k = 0; k < 3; )
               {
                  if(k == 0)
                  {
                     index1 = 2;
                  }
                  else if(k == 1)
                  {
                     index1 = 0;
                  }
                  else if(k == 2)
                  {
                     index1 = 1;
                  }
                  TweenLite.to(_contArray[k],0.5,{
                     "x":_pointArray[index1].x,
                     "y":_pointArray[index1].y,
                     "onComplete":_funArray[k]
                  });
                  k++;
               }
            }
            return;
         }
         if(_contArray[0].x == _startPointArr[0].x)
         {
            for(t_i = 0; t_i < 3; )
            {
               index1 = t_i;
               TweenLite.to(_contArray[t_i],0.5,{
                  "x":_pointArray[index1].x,
                  "y":_pointArray[index1].y,
                  "onComplete":_funArray[t_i]
               });
               t_i++;
            }
         }
         else if(_contArray[0].x == _startPointArr[1].x)
         {
            for(t_j = 0; t_j < 3; )
            {
               index1 = int(t_j + 1);
               if(index1 > 2)
               {
                  index1 = 0;
               }
               TweenLite.to(_contArray[t_j],0.5,{
                  "x":_pointArray[index1].x,
                  "y":_pointArray[index1].y,
                  "onComplete":_funArray[t_j]
               });
               t_j++;
            }
         }
         else if(_contArray[0].x == _startPointArr[2].x)
         {
            for(t_k = 0; t_k < 3; )
            {
               if(t_k == 0)
               {
                  index1 = 2;
               }
               else
               {
                  index1 = int(t_k - 1);
               }
               TweenLite.to(_contArray[t_k],0.5,{
                  "x":_pointArray[index1].x,
                  "y":_pointArray[index1].y,
                  "onComplete":_funArray[t_k]
               });
               t_k++;
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
      
      private function enterframeHander(e:Event) : void
      {
         var total:int = 0;
         var len:int = 0;
         var i:int = 0;
         var level:int = 0;
         if(_upGradeMc.currentFrame == _upGradeMc.totalFrames - 1)
         {
            _upGradeMc.visible = false;
            _upGradeMc.gotoAndStop(_upGradeMc.totalFrames);
            SoundManager.instance.stop("170");
            SoundManager.instance.play("169");
            len = _contArray.length;
            for(i = 0; i < len; )
            {
               if(_contArray[i].info.level > 0)
               {
                  _contArray[i].selAlphe(1);
                  _contArray[i].upDataLevel();
               }
               i++;
            }
            if(_isAction)
            {
               gemstoAction();
            }
            else
            {
               level = curInfo.level;
               if(level >= 6)
               {
                  level = 6;
                  total = staticDataList[level].Exp - staticDataList[level - 1].Exp;
                  GemstoneManager.Instance.expBar.initBar(total,total,true);
                  GemstoneManager.Instance.gemstoneFrame.getMaskMc().visible = false;
                  return;
               }
               setCurInfo(curInfo.fightSpiritId,level);
               level++;
               total = staticDataList[level].Exp - staticDataList[level - 1].Exp;
               GemstoneManager.Instance.expBar.initBar(0,total);
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
         for each(var tmp in _contArray)
         {
            if(tmp)
            {
               TweenLite.killTweensOf(tmp,true);
            }
            ObjectUtils.disposeObject(tmp);
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
      
      public function set staticDataList(value:Vector.<GemstoneStaticInfo>) : void
      {
         _staticDataList = value;
      }
   }
}

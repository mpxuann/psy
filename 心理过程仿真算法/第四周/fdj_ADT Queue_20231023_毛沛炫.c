#include<stdio.h>
#include<stdlib.h>
#ifndef Max
#define Max 50
#endif

typedef int ElementType;
typedef struct Node* PtrtoNode;
typedef PtrtoNode ADT;

struct Node
{
    ElementType capacity;
    ElementType size;
    ElementType* Arr;
    ElementType front,rear;    
};

ADT initialQueue(ADT Queue);
void enQueue(ADT Queue);
void deQueue(ADT Queue);
void makeEmpty(ADT Queue);
ElementType isEmpty(ADT Queue);
ElementType isFull(ADT Queue);
ElementType Assess(ElementType coordinate,ADT Queue);

ElementType main()
{
    ElementType N;
    ADT q;
    ADT initialQueue(Queue);
}

ADT initialQueue(ADT Queue)
{
    Queue->Arr = (ElementType*)malloc(Max*sizeof(ElementType));
    Queue->capacity = Max;
    Queue->size = 0;
    Queue->front = Queue->rear = 0;
    return Queue;
}

ElementType isEmpty(ADT Queue)
{
    return Queue->size == 0;
}

ElementType isFull(ADT Queue)
{
    return Queue->size  == Queue->capacity;
}

void enQueue(ADT Queue)
{
    if(isFull(Queue))
        return Queue;
    scanf("%d",&Queue->Arr[Queue->rear]);
    Queue->rear = Assess(Queue->rear,Queue);
    Queue->size++;
    return Queue;
}

ElementType Assess(ElementType coordinate,ADT Queue)
{
    if(++coordinate == Queue->capacity)
        return coordinate;
}

void deQueue(ADT Queue)
{
    if(isEmpty(Queue))
        return Queue;
    Queue->front = Assess(Queue->front,Queue);
    Queue->size--;
    return Queue;
}

void makeEmpty(ADT Queue)
{
    Queue->rear = Queue->front;
    Queue->size = 0;
}
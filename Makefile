DB_URL=postgresql://root:secret@localhost:5433/simple_bank?sslmode=disable

postgres:
	docker run  --name postgres12 -p 5433:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:12-alpine

createdb:
	docker exec -it postgres12 createdb --username=root --owner=root simple_bank

dropdb:
	docker exec -it postgres12 dropdb simple_bank

sqlc:
	sqlc generate

migrateup:
	migrate -path db/migration -database "$(DB_URL)" -verbose up

migratedown:
	migrate -path db/migration -database "$(DB_URL)" -verbose down

test:
	go test -v -cover ./...

.PHONY: postgres createdb dropdb sqlc migrateup migratedown